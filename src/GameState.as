package
{
    import org.flixel.FlxState;
    import org.flixel.FlxText;

    public class GameState extends FlxState
    {
        private var player:Player;

        public function GameState()
        {

            var text:FlxText = new FlxText(50, 50, 500, "Hello Ludum Dare 28");
            add(text);

            player = new Player(400, 400);
            add(player);
        }
    }
}
