package
{
    import org.flixel.FlxG;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
    import org.flixel.FlxText;

    public class IntroState extends FlxState
    {

        [Embed('../assets/Boomerang_2_cropped_intro_.png')] private var BoomerangImage:Class;

        public function IntroState():void
        {
            var boomerangSprite:FlxSprite = new FlxSprite(270, 20, BoomerangImage);
            add(boomerangSprite);


            var startText:FlxText = new FlxText(285, 300, 1000, "Boomerang");
            startText.setFormat(null, 34);
            add(startText);

            var controlsText:FlxText = new FlxText(40, 390, 700, "WASD or Arrow Keys for Movement. Aim with mouse and left click to throw the boomerang.");
            controlsText.setFormat(null, 16);
            add(controlsText);

            var warningText:FlxText = new FlxText(40, 440, 1000, "You only get one boomerang so be careful where you throw it.");
            warningText.setFormat(null, 16);
            add(warningText);

            var startText:FlxText = new FlxText(240, 500, 1000, "Left mouse click to start");
            startText.setFormat(null, 18, 0xffcf0000);
            add(startText);

            var credits:FlxText = new FlxText(100, 550, 1000, "Made for Ludum Dare 28 by Steven Thompson - @therealstevenjt on twitter");
            credits.setFormat(null, 13);
            add(credits);
        }

        override public function create():void
        {
            FlxG.bgColor = 0xff000000;
        }

        override public function update():void
        {
            if (FlxG.mouse.justReleased())
            {
                FlxG.switchState(new GameState(true));
            }
        }
    }
}
