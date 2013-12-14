package
{
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;

    public class Player extends FlxGroup
    {

        // Player Sprites
        [Embed('../assets/Player_cropped_scaled.png')] private var SpriteImage:Class;
        private var sprite:FlxSprite;

        // Player Position
        private var position:Vector2D;

        public function Player(x:int, y:int)
        {
            position = new Vector2D(0, 0);

            setupSprite();
            setPosition(x, y);
        }

        public function setupSprite():void
        {
            sprite = new FlxSprite(0, 0);
            sprite.loadGraphic(SpriteImage);
            add(sprite);
        }

        public function setPosition(x:int, y:int)
        {
            position.x = x;
            position.y = x;

            sprite.x = position.x;
            sprite.y = position.y;
        }
    }
}
