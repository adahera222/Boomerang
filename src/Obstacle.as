package
{
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;

    public class Obstacle extends FlxGroup
    {

        /***
         * Obstacle sprites
         */
        [Embed("../assets/Obstacle_cropped_scaled.png")] private var ObstacleImage:Class;
        private var obstacleSprite:FlxSprite;

        public function Obstacle(x:int, y:int):void
        {
            obstacleSprite = new FlxSprite(x, y);
            obstacleSprite.loadGraphic(ObstacleImage);
            add(obstacleSprite);
        }
    }
}
