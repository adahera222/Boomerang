package
{

    import org.flixel.FlxGame;

    [SWF(width="640", height="480", backgroundColor="#fff")]
    public class YouOnlyGetOne extends FlxGame
    {
        public function YouOnlyGetOne()
        {

            super(640, 480, GameState, 1);


        }
    }
}
