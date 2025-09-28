/**
 *Submitted for verification at basescan.org on 2025-01-15
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MotorcycleActions {
    bool public isStarted;
    bool public isHeadlightOn;
    uint public distanceTraveled;

    event MotorcycleStarted(bool state);
    event HeadlightToggled(bool state);
    event DistanceTraveled(uint distance);

    // Constructeur pour initialiser l'état de la moto
    constructor() {
        isStarted = false;
        isHeadlightOn = false;
        distanceTraveled = 0;
    }

    // Fonction pour démarrer ou arrêter la moto
    function startMotorcycle() public {
        isStarted = !isStarted;
        emit MotorcycleStarted(isStarted);
    }

    // Fonction pour allumer ou éteindre le phare
    function toggleHeadlight() public {
        isHeadlightOn = !isHeadlightOn;
        emit HeadlightToggled(isHeadlightOn);
    }

    // Fonction pour avancer d'une distance aléatoire
    function move() public {
        require(isStarted, "La moto doit etre demarree pour avancer.");
        uint randomDistance = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 101; // Distance entre 0 et 100
        distanceTraveled += randomDistance;
        emit DistanceTraveled(randomDistance);
    }

    // Fonction pour obtenir l'état complet de la moto
    function getMotorcycleStatus() public view returns (string memory) {
        string memory startedStatus = isStarted ? "demarree" : "arretee";
        string memory headlightStatus = isHeadlightOn ? "allume" : "eteint";
        return string(abi.encodePacked(
            "Moto: ", startedStatus, ", Phare: ", headlightStatus, ", Distance totale: ", uintToString(distanceTraveled), " km."
        ));
    }

    // Fonction utilitaire pour convertir un uint en string
    function uintToString(uint v) internal pure returns (string memory) {
        if (v == 0) {
            return "0";
        }
        uint maxLen = 100;
        bytes memory reversed = new bytes(maxLen);
        uint i = 0;
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[i++] = bytes1(uint8(48 + remainder));
        }
        bytes memory s = new bytes(i);
        for (uint j = 0; j < i; j++) {
            s[j] = reversed[i - 1 - j];
        }
        return string(s);
    }
}
