#let resume(
  name: none,
  contact: (),
  sections: (),
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
    align(center)[
      #for (key, value) in contact [
        #value #h(1em)
      ]
    ]
  }

  // Sections
  for section in sections {
    heading(level: 2, numbering: none)[#section.title]
    [#section.content]
  }

  doc
}

// Utility functions
#let entry(title, date, details) = {
  grid(
    columns: (auto, 1fr),
    gutter: 1em,
    [*#title*],
    align(right)[#date],
  )
  [#details]
}

#let cvSection(title, entries) = {
  heading(level: 2, numbering: none)[#title]
  for e in entries {
    entry(e.title, e.date, e.details)
  }
}