package
{
    import flash.ui.GameInput;

    import org.flixel.FlxG;
    import org.flixel.FlxState;
    import org.flixel.FlxText;

    public class NewSceneState extends FlxState
    {
        public function NewSceneState()
        {
            if (GameState.AreaIndex == 1)
            {
                var startText:FlxText = new FlxText(80, 150, 700, "You finished the Desert stage");
                startText.setFormat(null, 34);
                add(startText);

                var startText:FlxText = new FlxText(80, 350, 700, "Next is the Snow stage");
                startText.setFormat(null, 34);
                add(startText);
            }
            else if (GameState.AreaIndex == 2)
            {
                var startText:FlxText = new FlxText(80, 150, 700, "You finished the Snow stage");
                startText.setFormat(null, 34);
                add(startText);

                var startText:FlxText = new FlxText(80, 350, 700, "Next is the last stage, Forest");
                startText.setFormat(null, 34);
                add(startText);
            }
            else if (GameState.AreaIndex == 0)
            {
                var startText:FlxText = new FlxText(80, 150, 700, "You finished the Forest stage and won. Thanks for playing Boomerang!");
                startText.setFormat(null, 34);
                add(startText);
            }

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
            if (FlxG.mouse.justReleased())
            {
                if (GameState.AreaIndex == 0)
                {
                    FlxG.switchState(new IntroState());
                }
                else
                {
                    FlxG.switchState(new GameState(false));
                }

            }
        }
    }
}
