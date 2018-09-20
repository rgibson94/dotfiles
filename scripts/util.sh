!#/bin/bash

#  Initialize the array of colors. Creates an associative array mapping
#  color to ANSI color number. If no_color is set the array is created
#  but not filled.
#  Arguments:
#     None
function _initColors()
{
   declare -gA colors

   if [[ -z ${no_color-} ]]; then
      colors["black"]="0"
      colors["red"]="1"
      colors["green"]="2"
      colors["yellow"]="3"
      colors["blue"]="4"
      colors["magenta"]="5"
      colors["cyan"]="6"
      colors["white"]="7"
      colors["default"]="9"
   fi
}

#  Uses printf to generate an ANSI escape sequence for the specified color
#  Arguments:
#     Required:   $1:   Code prefix, either 3(foreground) or 4(background)
#                 $2:   Color to set, i.e. green
function _color()
{
   if [[ -v "colors[${2-default}]" ]]; then
      printf '\033[%d%dm' $1 "${colors[${2-default}]}"
   fi
}

#  ANSI escape sequence to set the foreground to the specified color
#  Arguments:
#     Required:   $1:   Color to set the foreground, i.e. green
function _fg()
{
   _color 3 "${1-}" 
}

#  ANSI escape sequence to set the background to the specified color
#  Arguments:
#     Required:   $1:   Color to set the background, i.e. green
function _fg()
{
   _color 4 "${1-}" 
}

#  Initialize the array of text attributes. Creates an associative array
#  mapping attribute name to ANSI code number. 
#  Arguments:
#     None
function _initAttributes()
{
   declare -gA attribs

   attribs["reset"]="0"
   attribs["bold"]="1"
   attribs["bright"]="1"
   attribs["dim"]="2"
   attribs["underline"]="4"
   attribs["underscore"]="4"
   attribs["reverse"]="7"
   attribs["inverse"]="7"
}

#  Uses printf to generate an ANSI escape sequence for the specified attribute.
#  Arguments:
#     Required:   $1:   Attribute name, i.e. underline
function _attribute()
{
   if [[ -v "attribs[$1]" ]]; then
      printf '\033[%dm' ${attribs[$1]}
   fi
}

#  Resets all attributes. 
#  Arguments:
#     None
function _none()
{
   _attribute "reset"
}

#  Sets the bold/bright attribute
#  Arguments:
#     None
function _bold()
{
   _attribute "bold"
}

#  Sets the dim attribute
#  Arguments:
#     None
function _dim()
{
   _attribute "dim"
}

#  Sets the underline attribute
#  Arguments:
#     None
function _underline()
{
   _attribute "underline"
}

#  Sets the reverse attribute
#  Arguments:
#     None
function _reverse()
{
   _attribute "reverse"
}

#  Clears the line from the cursor to the end of the line 
#  Arguments:
#     None
function _eraseEOL()
{
   printf '\033[0K'
}

#  Clears the line from the start of the line to the cursor
#  Arguments:
#     None
function _eraseSOL()
{
   printf '\033[1K'
}

#  Clears the entire line 
#  Arguments:
#     None
function _eraseLine()
{
   printf '\033[2K'
}

#  Check the reported operating system
#  Arguments:
#     Required:   $1:  Expected operating system, i.e. msys
function _isOS()
{
   if [[ "$1" = "${OSTYPE}" ]]; then
      return 0
   fi
   return 1
}
