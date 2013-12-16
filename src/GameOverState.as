package
{
    import org.flixel.FlxG;
    import org.flixel.FlxState;
    import org.flixel.FlxText;

    public class GameOverState extends FlxState
    {
        public function GameOverState()
        {
            var startText:FlxText = new FlxText(280, 300, 1000, "Game Over");
            startText.setFormat(null, 34);
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
