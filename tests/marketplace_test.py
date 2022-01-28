import pytest 

from brownie import Tether, CoinA, CoinB, CoinC, CoinD, accounts

@pytest.fixture
def tether():
    tether = accounts[0].deploy(Tether)
    tether.transfer(accounts[1],1000,{'from' : accounts[0]})
    return tether

# @pytest.fixture
# def test_account():
    

@pytest.fixture
def coinA(tether):
    return accounts[0].deploy(CoinA, tether.address)

@pytest.fixture
def coinB(tether):
    return accounts[0].deploy(CoinB, tether.address)

@pytest.fixture
def coinC(tether):
    return accounts[0].deploy(CoinC, tether.address)

@pytest.fixture
def coinD(tether):
    return accounts[0].deploy(CoinD, tether.address)


def test_transfer(tether, coinA, web3):

    tether.approve(accounts[0],100, {'from': accounts[1]})
    coinA.buyCoins(accounts[1], 10, 10)
    assert tether.balanceOf(accounts[1]) == 900

    tether.approve(accounts[1],100)
    coinA.sellCoins(accounts[1],10,10)
    assert tether.balanceOf(accounts[1]) == 1000

    assert coinA.name() == 'CoinA'
