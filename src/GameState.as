package
{
    import org.flixel.FlxState;
    import org.flixel.FlxText;

    public class GameState extends FlxState
    {
        public function GameState()
        {

            var text:FlxText = new FlxText(50, 50, 500, "Hello Ludum Dare 28");
            add(text);

        }
    }
}
