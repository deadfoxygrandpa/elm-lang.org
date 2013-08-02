{-# LANGUAGE OverloadedStrings #-}
module ElmToHtml (linkedElmToHtml, elmToHtml, elmToJS) where

import Text.Regex
import Data.List

import Text.Blaze (preEscapedToMarkup)
import Text.Blaze.Html5 ((!))
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import Network.HTTP.Base (urlEncode)

import qualified Language.Elm as Elm
import Utils


linkedElmToHtml :: String -> String -> String -> String -> H.Html
linkedElmToHtml name link src1 src2 = elmToHtml name (join src1 src2 link)
  where join s1 s2 s3 = intercalate ("\n" ++ s2 ++ "\n") (splitRegex (mkRegex s3) s1)

-- | Using a page title and the full source of an Elm program, compile down to
--   a valid HTML document.
elmToHtml :: String -> String -> H.Html
elmToHtml name src =
  H.docTypeHtml $ do
      H.head $ do
        H.meta ! A.charset "UTF-8"
        H.title . H.toHtml $ name
        H.style ! A.type_ "text/css" $ preEscapedToMarkup
         ("a:link {text-decoration: none; color: rgb(15,102,230);}\
          \a:visited {text-decoration: none}\
          \a:active {text-decoration: none}\
          \a:hover {text-decoration: underline;\
          \color: rgb(234,21,122);}" :: String)
      H.body $ do
        let js = H.script ! A.type_ "text/javascript"
        js ! A.src (H.toValue ("/elm-mini.js" :: String)) $ ""
        js $ preEscapedToMarkup (Elm.compile src)
        js $ preEscapedToMarkup ("var runningElmModule = Elm.fullscreen(Elm." ++ Elm.moduleName src ++ ")")

elmToJS :: String -> String
elmToJS = Elm.compile