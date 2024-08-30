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
  let accent-color = rgb("#0077be")  // A nice blue color

  set page(
    paper: paper,
    margin: margin,
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)

  // Helper function for section titles
  let section-title(title) = {
    v(0.5em)
    text(weight: "bold", size: 1.2em)[#title]
    line(length: 100%, stroke: 0.5pt)
    v(0.3em)
  }

  // Header
  if name != none {
    align(center)[#text(weight: "bold", size: 1.5em, fill: accent-color)[#name]]
  }

  // Contact information
  if contact != () {
    let contact_entries = contact.pairs().map(((key, value)) => [#value])
    align(center)[
      #contact_entries.join([#h(1em)•#h(1em)])
    ]
  }

  // Add some space after the header
  v(0.5em)

  // Create a grid for the main layout
  grid(
    columns: (30%, 70%),
    gutter: 1em,
    {
      // Sidebar
      v(1em)
      if summary != none {
        section-title("Summary")
        [#summary]
        v(1em)
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
      // Main content
      for section in main_sections {
        section-title(section.title)
        for entry in section.entries {
          grid(
            columns: (auto, 1fr),
            gutter: 1em,
            text(weight: "bold", fill: accent-color)[#entry.title],
            align(right)[#emph[#entry.date]],
          )
          pad(left: 1em)[#entry.details]
          v(0.5em)
        }
      }
    }
  )

  doc
}