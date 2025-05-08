0 value Selected-theme

\ While I did add SL\"
\ it does ALLOT, so you cannot use it with , like this.
\ You would need to first write the items in reverse, which I don't want to
\ For those reasons, I do the following hack
\ EVALUATE is great

7 constant THEME-LENGTH
:noname
  s" create THEME-TEXTS" evaluate
    s\" < THEME: Light >\0" drop ,
    s\" < THEME: Dark >\0" drop ,
    s\" < THEME: Darker >\0" drop ,
    s\" < THEME: APERTURE >\0" drop ,
    s\" < THEME: H4x0r >\0" drop ,
    s\" < THEME: Kanagawa >\0" drop ,
    s\" < THEME: Gruvbox Light >\0" drop ,
; execute

255 176 0 255 >color constant APERTURE-COLOR

\ kanagawa theme: https://github.com/rebelot/kanagawa.nvim
$1f $1f $28 255 >color constant K-BG
$dc $d7 $ba 255 >color constant K-FG
$c3 $40 $43 255 >color constant K-RED
$98 $bb $6c 255 >color constant K-GREEN
$e6 $c3 $84 255 >color constant K-YELLOW
$d2 $7e $99 255 >color constant K-PINK
$7f $b4 $ca 255 >color constant K-BLUE
$93 $81 $a9 255 >color constant K-MAGENTA
$7a $a8 $9f 255 >color constant K-CYAN
$e8 $24 $24 255 >color constant K-BRIGHT-RED
$e9 $8a $00 255 >color constant K-ORANGE

\ Gruvbox theme: https://github.com/morhetz/gruvbox
$fb $f1 $c7 255 >color constant G-BG
$3c $38 $36 255 >color constant G-FG
$cc $24 $1d 255 >color constant G-RED
$98 $97 $1a 255 >color constant G-GREEN
$d7 $99 $21 255 >color constant G-YELLOW
$45 $85 $88 255 >color constant G-BLUE
$b1 $62 $86 255 >color constant G-PURPLE
$68 $9d $6a 255 >color constant G-AQUA
$d6 $5d $0e 255 >color constant G-ORANGE
$fa $bd $2f 255 >color constant G-BRIGHT-WELLOW

: beam-color! ( a -- )
  Beam-color
  over color-r c@ over color-r c!
  over color-g c@ over color-g c!
  swap color-b c@ swap color-b c!
;

: default-colors ( -- )
  WHITE to Bg-color
  GRAY to Fg-color

  RED to I-color
  YELLOW to J-color
  PURPLE to L-color
  PINK to T-color
  SKYBLUE to O-color
  GREEN to S-color
  BLUE to Z-color

  DEF-MESSAGE-RECT-COLOR to Message-rect-color
  RED to Message-text-color

  GOLD beam-color!
;

: all-pices-color! ( a -- )
  dup to I-color
  dup to J-color
  dup to L-color
  dup to T-color
  dup to O-color
  dup to S-color
      to Z-color
;

: apply-theme ( -- )
  Selected-theme case
    0 of \ LIGHT
      default-colors
    endof
    1 of \ DARK
      default-colors
      DARKGRAY to Bg-color
      BLACK to Fg-color
    endof
    2 of \ DARKER
      default-colors
      BLACK to Bg-color
      GRAY to Fg-color
    endof
    3 of \ APERTURE
      BLACK to Bg-color
      APERTURE-COLOR to Fg-color
      APERTURE-COLOR all-pices-color!
      BLACK beam-color!
      BLACK to Message-rect-color
      APERTURE-COLOR to Message-text-color
    endof
    4 of \ H4X0R
      BLACK     to Bg-color
      DARKGREEN to Fg-color
      GREEN     all-pices-color!
      DARKGREEN beam-color!
      DARKGREEN to Message-rect-color
      GREEN     to Message-text-color
    endof
    5 of \ KANAGAWA
      K-BG to Bg-color
      K-FG to Fg-color

      K-RED     to I-color
      K-YELLOW  to J-color
      K-MAGENTA to L-color
      K-PINK    to T-color
      K-CYAN    to O-color
      K-GREEN   to S-color
      K-BLUE    to Z-color

      DEF-MESSAGE-RECT-COLOR to Message-rect-color
      K-BRIGHT-RED to Message-text-color

      K-ORANGE beam-color!
    endof
    6 of \ GRUVBOX
      G-BG to Bg-color
      G-FG to Fg-color

      G-RED    to I-color
      G-YELLOW to J-color
      G-PURPLE to L-color
      G-ORANGE to T-color
      G-AQUA   to O-color
      G-GREEN  to S-color
      G-BLUE   to Z-color

      DEF-MESSAGE-RECT-COLOR to Message-rect-color
      G-RED to Message-text-color

      G-BRIGHT-WELLOW beam-color!
    endof
  endcase
;

: change-theme ( f -- ) \ -1 right
  if
    Selected-theme 1+ THEME-LENGTH mod to Selected-theme
  else
    Selected-theme dup 0= if drop THEME-LENGTH then 1- to Selected-theme
  then

  apply-theme
;
