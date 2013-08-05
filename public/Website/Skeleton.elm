
module Website.Skeleton where

import JavaScript as JS
import open Website.ColorScheme
import Graphics.Input as Input

navigation = Input.customButtons ""

button (name, href, clr) =
 let btn alpha =
       flow down [ color (rgba 253 243 231 alpha) . container 100 58 middle .
                   width 100 . centered . Text.color black <| toText name
                 , color clr (spacer 100 2) ]
 in  link href (navigation.customButton href (btn 0) (btn 0.1) (btn 0.2))

buttons = flow right . map button <|
  [ ("About2"   , "/About.elm"        , accent1)
  , ("Examples2", "/Examples.elm"     , accent2)
  , ("Docs2"    , "/Documentation.elm", accent3)
  , ("Download2", "/Download.elm"     , accent4) ]

title w =
 let ttl = Text.link "/" . Text.color black . Text.height 2 . bold <| toText "AI in Elm"
 in  container w 60 midLeft (text ttl)

heading outer inner =
  let header = container outer 60 middle <|
               title (inner - widthOf buttons) `beside` buttons
  in  layers <| [ flow down [ color lightGrey (spacer outer 58)
                            , color mediumGrey (spacer outer 1) ]
                , header ]

skeleton bodyFunc outer =
  let inner = if outer < 840 then outer - 40 else 800
      body = bodyFunc inner
  in flow down
       [ heading outer inner
       , spacer outer 10
       , container outer (heightOf body) middle body
       , container outer 50 midBottom . Text.centered <|
         Text.color (rgb 145 145 145) (Text.toText "&copy; 2013 ") ++
             Text.link "https://github.com/deadfoxygrandpa" (Text.toText "Alex Neslusan")
       ]

redirect = JS.fromString <~ navigation.events
foreign export jsevent "redirect"
  redirect : Signal JSString
