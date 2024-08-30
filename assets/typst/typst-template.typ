#let resume(
  name: none,
  contact: (),
  summary: none,
  skills: (),
  main_sections: (),
  margin: (x: 0.75in, y: 0.75in),
  paper: "us-letter",
  lang: "en",
  region: "US",
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
           font: "Inria Serif",
           size: fontsize)

  // Helper function for section titles
  let section-title(title) = {
    v(0.5em)
    text(weight: "bold", size: 1.2em)[#title]
    line(length: 100%, stroke: 0.5pt)
    v(0.3em)
  }

  // Header
  // Name and summary
  let (first-name, last-name) = to-string(name).split(" ")
  [
    #text(weight: "bold", size: 2em, fill: accent-color)[#first-name]
    #text(weight: "bold", size: 2em, fill: black)[#last-name]
  ]
  v(0.5em)
  if summary != none {
    [#summary]
  }

  // Main content grid
  grid(
    columns: (30%, 70%),
    gutter: 1em,
    {
      // Sidebar
      // Contact information
      section-title("Contact Info")
      for (key, value) in contact {
        [#value]
        linebreak()
      }

      if skills != () {
        section-title("Skills")
        for category in skills {
          text(weight: "bold")[#category.name]
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
            text(style: "italic")[#entry.date],
            text(weight: "bold", fill: accent-color)[#entry.title],
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