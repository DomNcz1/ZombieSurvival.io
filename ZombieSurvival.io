<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ZombieSurvival.io</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            overflow: hidden;
        }

        canvas {
            display: block;
            margin: 0 auto;
        }

        .button {
            position: absolute;
            padding: 10px;
            background-color: #666;
            color: white;
            border: none;
            cursor: pointer;
        }

        .button:hover {
            background-color: #444;
        }
    </style>
</head>
<body>
    <h1 style="text-align:center;">ZombieSurvival.io</h1>

    <script>
        // Create the canvas for the game
        const canvas = document.createElement('canvas');
        document.body.appendChild(canvas);
        const ctx = canvas.getContext('2d');

        // Set canvas size
        canvas.width = 1200;
        canvas.height = 800;

        // Player settings
        const player = {
            x: canvas.width / 2,
            y: canvas.height / 2,
            width: 50,
            height: 50,
            speed: 2,
            color: 'red',
            sprinting: false
        };

        // Zombie settings
        const zombie = {
            x: canvas.width / 4,
            y: canvas.height / 4,
            width: 50,
            height: 50,
            color: 'green'
        };

        // Keyboard input state
        const keys = { W: false, A: false, S: false, D: false, Ctrl: false };

        // Function to handle movement
        function movePlayer() {
            let speed = player.sprinting ? player.speed * 2 : player.speed;

            if (keys.W) player.y -= speed;
            if (keys.A) player.x -= speed;
            if (keys.S) player.y += speed;
            if (keys.D) player.x += speed;
        }

        // Function to check if the player collides with the zombie
        function checkCollision() {
            if (player.x < zombie.x + zombie.width &&
                player.x + player.width > zombie.x &&
                player.y < zombie.y + zombie.height &&
                player.y + player.height > zombie.y) {
                // If a collision happens, reset the player
                alert("You were eaten by the zombie!");
                resetPlayer();
            }
        }

        // Reset player position
        function resetPlayer() {
            player.x = canvas.width / 2;
            player.y = canvas.height / 2;
        }

        // Update game loop
        function update() {
            movePlayer();
            checkCollision();

            // Draw the background
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            // Draw the player
            ctx.fillStyle = player.color;
            ctx.fillRect(player.x, player.y, player.width, player.height);

            // Draw the zombie
            ctx.fillStyle = zombie.color;
            ctx.fillRect(zombie.x, zombie.y, zombie.width, zombie.height);

            requestAnimationFrame(update);
        }

        // Event listeners for keyboard input
        window.addEventListener('keydown', (e) => {
            if (e.key === 'w' || e.key === 'W') keys.W = true;
            if (e.key === 'a' || e.key === 'A') keys.A = true;
            if (e.key === 's' || e.key === 'S') keys.S = true;
            if (e.key === 'd' || e.key === 'D') keys.D = true;
            if (e.key === 'Control') keys.Ctrl = true;
        });

        window.addEventListener('keyup', (e) => {
            if (e.key === 'w' || e.key === 'W') keys.W = false;
            if (e.key === 'a' || e.key === 'A') keys.A = false;
            if (e.key === 's' || e.key === 'S') keys.S = false;
            if (e.key === 'd' || e.key === 'D') keys.D = false;
            if (e.key === 'Control') keys.Ctrl = false;
        });

        // Function to create mobile controls
        function createMobileControls() {
            const buttonWidth = 100;
            const buttonHeight = 50;
            const padding = 20;

            // Left button
            const moveLeftButton = document.createElement('button');
            moveLeftButton.textContent = 'Left';
            moveLeftButton.classList.add('button');
            moveLeftButton.style.left = `${padding}px`;
            moveLeftButton.style.bottom = `${padding}px`;
            moveLeftButton.addEventListener('touchstart', () => keys.A = true);
            moveLeftButton.addEventListener('touchend', () => keys.A = false);
            document.body.appendChild(moveLeftButton);

            // Right button
            const moveRightButton = document.createElement('button');
            moveRightButton.textContent = 'Right';
            moveRightButton.classList.add('button');
            moveRightButton.style.left = `${padding + buttonWidth + padding}px`;
            moveRightButton.style.bottom = `${padding}px`;
            moveRightButton.addEventListener('touchstart', () => keys.D = true);
            moveRightButton.addEventListener('touchend', () => keys.D = false);
            document.body.appendChild(moveRightButton);

            // Up button
            const moveUpButton = document.createElement('button');
            moveUpButton.textContent = 'Up';
            moveUpButton.classList.add('button');
            moveUpButton.style.left = `${padding + buttonWidth / 2}px`;
            moveUpButton.style.bottom = `${padding + buttonHeight + padding}px`;
            moveUpButton.addEventListener('touchstart', () => keys.W = true);
            moveUpButton.addEventListener('touchend', () => keys.W = false);
            document.body.appendChild(moveUpButton);

            // Down button
            const moveDownButton = document.createElement('button');
            moveDownButton.textContent = 'Down';
            moveDownButton.classList.add('button');
            moveDownButton.style.left = `${padding + buttonWidth / 2}px`;
            moveDownButton.style.bottom = `${padding}px`;
            moveDownButton.addEventListener('touchstart', () => keys.S = true);
            moveDownButton.addEventListener('touchend', () => keys.S = false);
            document.body.appendChild(moveDownButton);

            // Sprint button
            const sprintButton = document.createElement('button');
            sprintButton.textContent = 'Sprint';
            sprintButton.classList.add('button');
            sprintButton.style.right = `${padding}px`;
            sprintButton.style.bottom = `${padding + buttonHeight * 2}px`;
            sprintButton.addEventListener('touchstart', () => player.sprinting = true);
            sprintButton.addEventListener('touchend', () => player.sprinting = false);
            document.body.appendChild(sprintButton);
        }

        // Check if the user is on mobile
        if (/iPhone|iPad|iPod|Android/i.test(navigator.userAgent)) {
            createMobileControls();
        }

        // Start the game loop
        update();

    </script>
</body>
</html>
