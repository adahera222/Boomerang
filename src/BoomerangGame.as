package
{

    import org.flixel.FlxG;
    import org.flixel.FlxGame;

    [SWF(width="800", height="600", backgroundColor="#fff")]
    public class BoomerangGame extends FlxGame
    {
        public function BoomerangGame()
        {
            super(800, 600, IntroState, 1);
            FlxG.debug = true;
            forceDebugger = true;
        }
    }
}
