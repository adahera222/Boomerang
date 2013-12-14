package
{
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;

    public class Boomerang extends FlxGroup
    {
        // Boomerang Sprite
        [Embed('../assets/Boomerang_cropped_scaled.png')] private var BoomerangImage:Class;
        private var boomerangSprite:FlxSprite;

        private var position:Vector2D;

        public function Boomerang(x:int, y:int):void
        {

            boomerangSprite = new FlxSprite(0, 0);
            boomerangSprite.antialiasing = true;
            boomerangSprite.loadGraphic(BoomerangImage);
            add(boomerangSprite);

            position = new Vector2D(0, 0);
            setBoomerangPosition(x, y);
        }

        public function setBoomerangPosition(x:int, y:int):void
        {
            position.x = x;
            position.y = y;

            boomerangSprite.x = position.x;
            boomerangSprite.y = position.y;
        }

        public function setBoomerangAngle(angle:Number):void
        {
            boomerangSprite.angle = angle;
        }
    }
}
