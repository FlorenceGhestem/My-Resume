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
    let contact_entries = contact.pairs().map(((key, value)) => [#value])
    align(center)[
      #contact_entries.join([#h(1em)•#h(1em)])
    ]
  }

  // Add some space after the header
  v(0.5em)

  // Sections
  for section in sections {
    heading(level: 2, numbering: none, outlined: false)[#section.title]
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
    align(right)[#emph[#date]],
  )
  pad(left: 1em)[#details]
  v(0.5em)
}

#let cvSection(title, entries) = {
  for e in entries {
    entry(e.title, e.date, e.details)
  }
}