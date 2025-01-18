// SPDX-License-Identifier: MIT

pragma solidity ^0.8;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

// BooMirrorWorld is the place where boo's live to create xBOO. Grim becomes her evil half, ace
// This contract handles swapping to and from xBoo, SpookySwap's staking token.
contract BooMirrorWorld is ERC20("Boo MirrorWorld", "xBOO"), ERC20Permit("Boo MirrorWorld") {
    using SafeMath for uint256;
    IERC20 public boo;

    // Define the Boo token contract
    constructor(address _boo) {
        boo = IERC20(_boo);
    }

    // Locks Boo and mints xBoo
    function enterWithPermit(uint256 _amount, uint256 deadline, uint8 v, bytes32 r, bytes32 s) public {
        // Gets the amount of Boo locked in the contract
        uint256 totalBoo = boo.balanceOf(address(this));
        // Gets the amount of xBoo in existence
        uint256 totalShares = totalSupply();
        // If no xBoo exists, mint it 1:1 to the amount put in
        if (totalShares == 0 || totalBoo == 0) {
            _mint(msg.sender, _amount);
        } 
        // Calculate and mint the amount of xBoo the Boo is worth. The ratio will change overtime, as xBoo is burned/minted and Boo deposited + gained from fees / withdrawn.
        else {
            uint256 what = _amount.mul(totalShares).div(totalBoo);
            _mint(msg.sender, what);
        }
        // Lock the Boo in the contract
        IERC20Permit(address(boo)).permit(msg.sender, address(this), _amount, deadline, v, r, s);
        boo.transferFrom(msg.sender, address(this), _amount);
    }

    // Locks Boo and mints xBoo
    function enter(uint256 _amount) public {
        // Gets the amount of Boo locked in the contract
        uint256 totalBoo = boo.balanceOf(address(this));
        // Gets the amount of xBoo in existence
        uint256 totalShares = totalSupply();
        // If no xBoo exists, mint it 1:1 to the amount put in
        if (totalShares == 0 || totalBoo == 0) {
            _mint(msg.sender, _amount);
        } 
        // Calculate and mint the amount of xBoo the Boo is worth. The ratio will change overtime, as xBoo is burned/minted and Boo deposited + gained from fees / withdrawn.
        else {
            uint256 what = _amount.mul(totalShares).div(totalBoo);
            _mint(msg.sender, what);
        }
        // Lock the Boo in the contract
        boo.transferFrom(msg.sender, address(this), _amount);
    }

    // Unlocks the staked + gained Boo and burns xBoo
    function leave(uint256 _share) public {
        // Gets the amount of xBoo in existence
        uint256 totalShares = totalSupply();
        // Calculates the amount of Boo the xBoo is worth
        uint256 what = _share.mul(boo.balanceOf(address(this))).div(totalShares);
        _burn(msg.sender, _share);
        boo.transfer(msg.sender, what);
    }

    // returns the total amount of BOO an address has in the contract including fees earned
    function BOOBalance(address _account) external view returns (uint256 booAmount_) {
        uint256 xBOOAmount = balanceOf(_account);
        uint256 totalxBOO = totalSupply();
        booAmount_ = xBOOAmount.mul(boo.balanceOf(address(this))).div(totalxBOO);
    }

    // returns how much BOO someone gets for redeeming xBOO
    function xBOOForBOO(uint256 _xBOOAmount) external view returns (uint256 booAmount_) {
        uint256 totalxBOO = totalSupply();
        booAmount_ = _xBOOAmount.mul(boo.balanceOf(address(this))).div(totalxBOO);
    }

    // returns how much xBOO someone gets for depositing BOO
    function BOOForxBOO(uint256 _booAmount) external view returns (uint256 xBOOAmount_) {
        uint256 totalBoo = boo.balanceOf(address(this));
        uint256 totalxBOO = totalSupply();
        if (totalxBOO == 0 || totalBoo == 0) {
            xBOOAmount_ = _booAmount;
        }
        else {
            xBOOAmount_ = _booAmount.mul(totalxBOO).div(totalBoo);
        }
    }

}