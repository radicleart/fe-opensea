let Contract = artifacts.require('./Loopbomb.sol');

contract('Loopbomb', accounts => {
    Loopbomb.deployed().then(instance => {

        console.log(instance.abi);

    });
});
