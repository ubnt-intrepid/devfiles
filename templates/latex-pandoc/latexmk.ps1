param(
  [string] $subcommand = "build"
)

function latexmk {
  "c:\opt\texlive\2015\bin\win32\latexmk.exe"
}

switch ($subcommand) {
  "build"   { & (latexmk) -pdfdvi }
  "preview" { & (latexmk) -pdfdvi -pv }
  "clean"   { & (latexmk) -c }
}