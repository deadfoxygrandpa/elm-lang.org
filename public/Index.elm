import Website.Skeleton (skeleton)
import Website.Tiles (miniTiles)
import Website.ColorScheme

import Text as Text
import JavaScript as JavaScript
import Window as Window

intro = [markdown|

## Introduction

Welcome to AI in Elm, a website with a series of games where you write the AI!

|]

whatIsElm = [markdown|

### What is Elm?

Elm is a [functional reactive programming][frp] (FRP) language
that compiles to HTML, CSS, and JS. Read more on [Elm's official website][elm].

  [frp]: http://http://en.wikipedia.org/wiki/Functional_reactive_programming "functional reactive programming"
  [elm]: http://elm-lang.org
|]

exampleText = [markdown|

#### Learn by Example

The best way to learn Elm is [by example](/Examples.elm).
Start with the [basics](/examples/Basic.elm). Work up to
[intermediate examples](/examples/Intermediate.elm) and
[games](/blog/games-in-elm/part-0/Making-Pong.html).

The [About](/About.elm) and [Docs](/Documentation.elm) tabs
give even more info about Elm.

Together these resources illustrate the key features of Elm: [Functional Reactive Programming][frp], 
[strong][strong] [static][static] types with full [type inference][infer],
[Markdown support](/edit/examples/Elements/Markdown.elm), the
[core libraries](/Documentation.elm), and the [module system][modules].


  [frp]:    /learn/What-is-FRP.elm "functional reactive programming"
  [strong]: http://en.wikipedia.org/wiki/Strong_typing "strong typing"
  [static]: http://en.wikipedia.org/wiki/Type_system#Static_typing "static typing"
  [infer]:  http://en.wikipedia.org/wiki/Type_inference "type inference"
  [modules]: http://www.testblogpleaseignore.com/2012/06/19/announcing-elm-0-3-modules/ "Module System"

|]

resources = [markdown|

#### Videos and Resources

There are tons of resources available in the [About](/About.elm) and
[Docs](/Documentation.elm) tabs. The following videos provide a guided
tour through Elm:

* [Making the Web Functional][vid] motivates and introduces the core
  parts of Elm.
* [Introduction to Functional Reactive Programming][frp] explains FRP from
  scratch, building up to a simple Mario game and asynchronous HTTP requests.

  [vid]: http://www.infoq.com/presentations/Elm "Elm at Emerging Languages Camp"
  [exs]: https://github.com/evancz/elm-at-strangeloop#elm-at-strangeloop "Non-grainy Examples"
  [frp]: http://www.ustream.tv/recorded/29330499 "Functional Reactive Programming"

|]

tryOnline = [markdown|

#### Use the online editor

The [online editor](/try) lets you write and compile Elm without downloading
anything. It supports automatic compilation, editor customization, and inline
documentation.
|]

contact = [markdown|

#### Community

[Elm's mailing list][7] is the place to go for questions, announcements,
and discussion. Or check out the IRC channel at [`#elm` on freenode][irc].

 [7]: https://groups.google.com/forum/?fromgroups#!forum/elm-discuss "mailing list"
 [irc]: http://webchat.freenode.net/?channels=elm "#elm"

|]

examples = map (\(x,y) -> (x, y, "Intermediate/"))
  [ ("Analog Clock", "Clock")
  , ("Stamps", "Stamps")
  , ("Diagrams", "Physics")
  , ("Slide Show", "SlideShow")
  , ("Walking", "Walk")
  , ("Mario", "Mario")
  ]

content w =
  let tiles = miniTiles w examples
  in  flow down [ spacer 10 20
                , container w (heightOf tiles) middle tiles
                ]

infoq w =
  let lnk = "http://www.infoq.com/presentations/Elm"
      vid = fittedImage w 200 "/infoq.jpg"
  in  spacer 10 20 `above` layers [ vid, link lnk (spacer w 200 )]

tryElm w =
  flow down [ spacer 10 20
            , link "/try" (fittedImage w (w `div` 2) "editor.jpg") ]

info w =
  let sw = if w >= 800 then 300 else 200
      box txt pics = flow right [ width (w-(30+sw)) txt, spacer 30 10, pics sw ]
  in  flow down <| [ width w intro, spacer w 10 ] ++
      intersperse (spacer w 40)
       [ box exampleText content,
         box resources infoq,
         box tryOnline tryElm ]

main = lift (skeleton info) Window.width

title = constant (JavaScript.fromString "AI in Elm")
foreign export jsevent "title"
  title : Signal JSString
