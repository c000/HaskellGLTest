module Initialize
  ( initialize
  ) where

import Graphics.UI.SDL as SDL
import Graphics.Rendering.OpenGL as GL

initialize :: IO ()
initialize = do
  setVideoMode 640 480 32 [OpenGL]
  initializeGL

initializeGL :: IO ()
initializeGL = do
  glSetAttribute glDoubleBuffer 1
  mapM_ ($=! Enabled) [ clientState VertexArray
                      , lineSmooth
                      , blend
                      ]
  blendFunc $=! (GL.SrcAlpha, GL.OneMinusSrcAlpha)
