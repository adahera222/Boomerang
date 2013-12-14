package
{
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;

    public class Enemy extends FlxGroup
    {

        /**
         * Enemy Sprites
         */
        [Embed(source="../assets/Enemy_cropped_scaled.png")] private var EnemyImage:Class;
        private var enemySprite:FlxSprite;

        public function Enemy(x:int, y:int):void
        {
            enemySprite = new FlxSprite(x, y);
            enemySprite.loadGraphic(EnemyImage);
            add(enemySprite);
        }
    }
}
