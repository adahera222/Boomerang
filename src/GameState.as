package
{
    import org.flixel.FlxG;
    import org.flixel.FlxState;
    import org.flixel.FlxText;

    public class GameState extends FlxState
    {
        private var player:Player;

        public function GameState()
        {

            player = new Player(400, 400);
            add(player);
        }
    }
}
