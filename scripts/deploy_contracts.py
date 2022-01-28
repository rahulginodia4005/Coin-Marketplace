# from scripts.helpful_scripts import get_accounts

from brownie import Tether, CoinA, CoinB, CoinC, CoinD, network, config, accounts

from web3 import Web3

def deploy_contracts():
    tether = Tether.deploy({'from' : accounts[0]})
    coinA = CoinA.deploy(tether.address, {'from' : accounts[0]}, publish_source = config["networks"][network.show_active()].get("verify", False))
    coinB = CoinB.deploy(tether.address, {'from' : accounts[0]}, publish_source = config["networks"][network.show_active()].get("verify", False))
    coinC = CoinC.deploy(tether.address, {'from' : accounts[0]}, publish_source = config["networks"][network.show_active()].get("verify", False))
    coinD = CoinD.deploy(tether.address, {'from' : accounts[0]}, publish_source = config["networks"][network.show_active()].get("verify", False))
    tx = tether.transfer(accounts[1], 1000000000000000000000000, {'from' : accounts[0]})
    tx.wait(1)

def main():
    deploy_contracts()