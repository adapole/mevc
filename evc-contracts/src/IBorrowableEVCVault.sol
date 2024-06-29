// SPDX-License-Identifier: GPL-2.0-or-later

pragma solidity ^0.8.19;

import "evc/interfaces/IVault.sol";

interface IBorrowableEVCVault is IVault {
    function borrow(uint256 assets, address receiver) external;
    function repay(uint256 assets, address receiver) external;
    function pullDebt(address from, uint256 assets) external returns (bool);
    function liquidate(address violator, address collateral) external;

    // add EIP-7540 compatibility for RWAs
    function doCheckVaultStatus(bytes memory snapshot) external;
    function doTakeVaultSnapshot() external returns (bytes memory snapshot);
}
