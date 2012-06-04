import Control.Monad (forM_)
import Foreign.Marshal.Array (withArray)
import Graphics.UI.SDL as SDL
import Graphics.Rendering.OpenGL as GL

import Initialize (initialize)

main :: IO ()
main = do
  withInit [InitEverything] $ do
    initialize
    window <- getVideoSurface
    rendering window
  putStrLn "ENDED"

rendering window = do
  forM_ [a / 50 | a <-[0..400]] $ \arg -> do
    renderLineArg arg
    glSwapBuffers

renderLineArg :: GLfloat -> IO ()
renderLineArg arg = do
  withArray [ 0    , 0
            , c arg, s arg
            ] $ \ptr -> do
    arrayPointer VertexArray $=! VertexArrayDescriptor 2 Float 0 ptr
    drawArrays Lines 0 3

s :: GLfloat -> GLfloat
s = sin

c :: GLfloat -> GLfloat
c = cos
