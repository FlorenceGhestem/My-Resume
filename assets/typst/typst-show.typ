#show: doc => resume(
$if(name)$
  name: [$name$],
$endif$
$if(contact)$
  contact: (
$for(contact/pairs)$
    $contact.key$: [$contact.value$],
$endfor$
  ),
$endif$
$if(sections)$
  sections: (
$for(sections)$
    (
      title: [$it.title$],
      content: [$it.content$]
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