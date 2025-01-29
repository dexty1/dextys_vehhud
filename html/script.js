let speed = 0;
let fuel = 0;

// Funktio, joka päivitttää palkit
window.addEventListener('message', function(event) {
    if (event.data.type === 'update') {
        speed = event.data.speed;
        fuel = event.data.fuel;

        updateHUD();
    }
});

// Funktio päivittää HUD:n ulkoasun
function updateHUD() {
    // Nopeus palkki
    const speedFill = document.getElementById('speed-fill');
    speedFill.style.width = `${(speed / 400) * 100}%`;
    speedFill.style.backgroundColor = getSpeedColor(speed);

    // Polttoaine palkki
    const fuelFill = document.getElementById('fuel-fill');
    fuelFill.style.width = `${(fuel / 100) * 100}%`;
    fuelFill.style.backgroundColor = getFuelColor(fuel);
}

// Funktio nopeuden väriin
function getSpeedColor(speed) {
    if (speed < 100) {
        return 'green';
    } else if (speed < 200) {
        return 'yellow';
    } else if (speed < 300) {
        return 'orange';
    } else {
        return 'red';
    }
}

// Funktio polttoaineen väriin
function getFuelColor(fuel) {
    if (fuel > 70) {
        return 'green';
    } else if (fuel > 30) {
        return 'yellow';
    } else {
        return 'red';
    }
}
