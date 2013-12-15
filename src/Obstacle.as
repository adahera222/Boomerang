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

        [Embed("../assets/Wall_cropped_scaled.png")] private var WallImage_0:Class;
        [Embed("../assets/Wall_1_cropped_scaled.png")] private var WallImage_1:Class;

        public function Obstacle(x:int, y:int, wall:Boolean = false, wallSide:int = 0):void
        {
            obstacleSprite = new FlxSprite(x, y);
            if (wall)
            {
                if (wallSide == 0)
                {
                    obstacleSprite.loadGraphic(WallImage_0);
                }
                else
                {
                    obstacleSprite.loadGraphic(WallImage_1);
                }

            }
            else
            {
                obstacleSprite.loadGraphic(ObstacleImage);
            }

            add(obstacleSprite);
        }
    }
}
