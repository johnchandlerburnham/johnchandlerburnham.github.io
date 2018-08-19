--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid         (mappend)
import qualified Data.Set            as S
import           Hakyll
import           Text.Pandoc.Options

--------------------------------------------------------------------------------
config :: Configuration
config = defaultConfiguration { destinationDirectory = "_site"
                              , deployCommand        = "bash deploy.sh deploy"
                              }

main :: IO ()
main = hakyllWith config $ do
  let postPattern       = "posts/*" .||. "notes/*/*"
  let projPostPattern   = "projects/**.md"
  let projSourcePattern = "projects/**" .&&. (complement projPostPattern)

  match "images/*" $ do
    route idRoute
    compile copyFileCompiler

  match "css/*" $ do
    route idRoute
    compile compressCssCompiler

  match (fromList ["index.md", "projects.md"]) $ do
    route $ setExtension "html"
    compile
      $   pandocMathCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls

  tags <- buildTags postPattern (fromCapture "tags/*.html")

  tagsRules tags $ \tag pat -> do
    let title = "Posts tagged \"" ++ tag ++ "\""
    route idRoute
    compile $ do
      posts <- recentFirst =<< loadAll pat
      let ctx =
            constField "title" title
              `mappend` listField "posts" (postCtxWithTags tags) (return posts)
              `mappend` defaultContext
      makeItem ""
        >>= loadAndApplyTemplate "templates/tag.html"     ctx
        >>= loadAndApplyTemplate "templates/default.html" ctx
        >>= relativizeUrls

  match postPattern $ do
    route $ setExtension "html"
    compile
      $   pandocMathCompiler
      >>= loadAndApplyTemplate "templates/post.html"    (postCtxWithTags tags)
      >>= loadAndApplyTemplate "templates/default.html" (postCtxWithTags tags)
      >>= relativizeUrls

  match projPostPattern $ do
    route $ setExtension "html"
    compile
      $   pandocMathCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls

  match projSourcePattern $ do
    route idRoute
    compile copyFileCompiler

  create ["posts.html"] $ do
    route idRoute
    compile $ do
      posts <- recentFirst =<< loadAll postPattern
      let archiveCtx =
            listField "posts" (postCtxWithTags tags) (return posts)
              `mappend` constField "title" "Posts"
              `mappend` defaultContext
      makeItem ""
        >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
        >>= loadAndApplyTemplate "templates/default.html" archiveCtx
        >>= relativizeUrls

  match "templates/*" $ compile templateBodyCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx = dateField "date" "%B %e, %Y" `mappend` defaultContext

postCtxWithTags :: Tags -> Context String
postCtxWithTags tags = tagsField "tags" tags `mappend` postCtx

pandocMathCompiler :: Compiler (Item String)
pandocMathCompiler =
  let mathExtensions =
        [Ext_tex_math_dollars, Ext_tex_math_double_backslash, Ext_latex_macros]
      defaultExtensions = writerExtensions defaultHakyllWriterOptions
      newExtensions     = defaultExtensions `mappend` extensionsFromList mathExtensions
      writerOptions     = defaultHakyllWriterOptions
        { writerTableOfContents = False
        , writerExtensions      = newExtensions
        , writerHTMLMathMethod  = MathJax ""
        }
  in  pandocCompilerWith defaultHakyllReaderOptions writerOptions
