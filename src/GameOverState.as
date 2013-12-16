package
{
    import org.flixel.FlxG;
    import org.flixel.FlxState;
    import org.flixel.FlxText;

    public class GameOverState extends FlxState
    {
        public function GameOverState()
        {
            var startText:FlxText = new FlxText(290, 250, 1000, "Game Over");
            startText.setFormat(null, 34);
            add(startText);

            var startText:FlxText = new FlxText(80, 540, 700, "Click the left mouse button to continue.");
            startText.setFormat(null, 26);
            add(startText);
        }

        override public function create():void
        {
            FlxG.bgColor = 0xff000000;
        }

        override public function update():void
        {
            if (FlxG.mouse.justPressed())
            {
                FlxG.switchState(new IntroState());
            }
        }
    }
}
