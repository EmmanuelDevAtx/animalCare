//SPDX-License-Identifier: Mit
pragma solidity ^0.8.0;

library MathLibrary{
    function _checkCeroValue(
        uint _value,
        uint _reduceValue
    ) internal pure returns (uint) {
        if (_value < _reduceValue) {
            return 0;
        }
        if (_value != 0) {
            return (_value - _reduceValue);
        }
        return 0;
    }

    function _checkMaxNumber(uint _value, uint maxTargetLevel)internal pure returns(uint){
        if(_value >= maxTargetLevel){
            return maxTargetLevel;
        }
        return _value;
    }
}