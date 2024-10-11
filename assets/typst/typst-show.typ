#show: doc => resume(
$if(name)$
  name: [$name$],
$endif$
$if(contact)$
  contact: (
$for(contact)$
    (
      text: [$it.text$],
      link: [$it.link$]
    ),
$endfor$
  ),
$endif$
$if(summary)$
  summary: [$summary$],
$endif$
$if(skills)$
  skills: (
$for(skills)$
    (
      name: [$it.name$],
      items: (
$for(it.items)$
        [$it$],
$endfor$
      )
    ),
$endfor$
  ),
$endif$
$if(main_sections)$
  main_sections: (
$for(main_sections)$
    (
      title: [$it.title$],
      entries: (
$for(it.entries)$
        (
          title: [$it.title$],
          date: [$it.date$],
          organization: [$it.organization$],
          location: [$it.location$],
          description: (
$for(it.description)$
            [$it$],
$endfor$
          ),
        ),
$endfor$
      )
    ),
$endfor$
  ),
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
$endif$
$if(papersize)$
  paper: "$papersize$",
$endif$
$if(mainfont)$
  font: ("$mainfont$",),
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
  doc,
)