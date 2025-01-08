#let resume(
  name: none,
  contact: (),
  summary: none,
  skills: (),
  main_sections: (),
  margin: (x: 0.75in, y: 0.75in),
  paper: "us-letter",
  lang: "en",
  region: "UK",
  font: (),
  fontsize: 11pt,
  doc,
) = {
  // Define colors
  let accent-color = rgb("#0077be")  // Blue
  let grey-color = rgb("#666666")    // Grey for descriptions

  let to-string(content) = {
    if content.has("text") {
      if type(content.text) == "string" {
        content.text
      } else {
        to-string(content.text)
      }
    } else if content.has("children") {
      content.children.map(to-string).join("")
    } else if content.has("body") {
      to-string(content.body)
    } else if content == [ ] {
      " "
    }
  }

  set page(
    paper: paper,
    margin: margin,
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)

  let section-title(title) = {
    v(0.5em)
    text(weight: "bold", size: 1.2em)[#title]
    line(length: 100%, stroke: 0.5pt)
    v(0.3em)
  }

  let (first-name, last-name) = to-string(name).split(" ")
  [
    #text(size: 2em, fill: accent-color)[#first-name]
    #text(weight: "bold", size: 2em, fill: black)[#last-name]
  ]
  v(0.5em)
  if summary != none {
    [#summary]
  }

  grid(
    columns: (30%, 60%),
    gutter: 1em,
    {
      // Sidebar
      // Contact information
      section-title("Contact")
      for (value) in contact {
        if value.link != none {
          [
            #link(to-string(value.link))[#value.text]
          ]
        } else {
          [#value.text]
        }
        v(0.3em)
      }

      if skills != () {
        section-title("Compétences")
        for category in skills {
          text(weight: "bold")[#category.name]
          set text(size: 0.8em)
          list(..category.items)
          v(0.5em)
        }
      }
    },
    {
      // Main sections
      for section in main_sections {
        section-title(section.title)
        for entry in section.entries {
          grid(
            columns: (auto, 1fr),
            gutter: 1em,
            text(weight: "bold", fill: accent-color)[#entry.title],
            align(right)[#emph[#entry.date]],
          )
          [#entry.organization, #entry.location]
          if entry.description != none {
            list(
              ..entry.description.map(item => [#text(fill: grey-color)[#item]])
            )
          }
          v(0.5em)
        }
      }
    }
  )

  doc
}