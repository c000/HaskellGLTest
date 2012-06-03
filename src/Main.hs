import Control.Monad (forM_)
import Foreign.Marshal.Array (withArray, newArray)
import Graphics.UI.SDL as SDL
import Graphics.Rendering.OpenGL as GL
import GHC.Conc

main = do
  withInit [InitEverything] $ do
    setVideoMode 640 480 32 [OpenGL]
    glSetAttribute glDoubleBuffer 1
    clientState VertexArray $=! Enabled
    lineSmooth $=! Enabled
    blend $=! Enabled
    blendFunc $=! (GL.SrcAlpha, GL.OneMinusSrcAlpha)
    window <- getVideoSurface
    rendering window
  putStrLn "ENDED"

rendering window = do
  forM_ [a / 50 | a <-[0..400]] $ \arg -> do
    renderLineArg arg
    glSwapBuffers

renderLineArg arg = do
  withArray [ 0    , 0
            , c arg, s arg
            ] $ \ptr -> do
    arrayPointer VertexArray $=! VertexArrayDescriptor 2 Float 0 ptr
    drawArrays Lines 0 2
  -- renderPrimitive Lines $ do
  --   vertex $ Vertex2 0 (0 :: GLfloat)
  --   vertex $ Vertex2 (c arg) (s arg)

s :: GLfloat -> GLfloat
s = sin

c :: GLfloat -> GLfloat
c = cos
