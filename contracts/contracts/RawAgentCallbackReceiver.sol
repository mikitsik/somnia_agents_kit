// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract RawAgentCallbackReceiver {
    address public owner;
    uint256 public callbackCount;
    address public lastSender;
    bytes public lastData;

    event CallbackCaptured(
        address indexed sender,
        uint256 indexed callbackCount,
        bytes data
    );

    constructor() {
        owner = msg.sender;
    }

    fallback() external payable {
        callbackCount += 1;
        lastSender = msg.sender;
        lastData = msg.data;

        emit CallbackCaptured(msg.sender, callbackCount, msg.data);
    }

    receive() external payable {}
}
