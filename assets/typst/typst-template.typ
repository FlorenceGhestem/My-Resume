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
  set page(
    paper: paper,
    margin: margin,
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)

  // Header
  if name != none {
    align(center)[#text(weight: "bold", size: 1.5em)[#name]]
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
        heading(level: 2, numbering: none, outlined: false)[Summary]
        [#summary]
        v(1em)
      }
      
      if skills != () {
        heading(level: 2, numbering: none, outlined: false)[Skills]
        for category in skills {
          [*#category.name*]
          list(..category.items)
          v(0.5em)
        }
      }
    },
    {
      // Main content
      for section in main_sections {
        heading(level: 2, numbering: none, outlined: false)[#section.title]
        for entry in section.entries {
          grid(
            columns: (auto, 1fr),
            gutter: 1em,
            [*#entry.title*],
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