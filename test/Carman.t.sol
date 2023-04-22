// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "forge-std/Test.sol";
import "../src/CarManOpt.sol";

contract CarManTest is Test {
    CarManOpt public carManOpt;
    bytes32[] public proof1; 
    bytes32[] public proof2; 
    
    /*bytes32[] public proof2 = [
        0xc84747cf5e222f288a79b555a8f9dafc516d29891c653fba46d3de8d1422f156,
        0x3f451c96289948d48e00922a59c17861b137dbf6a638cc210643eb46d80c44f9,
        0xc2d602830a0c398e71953719e20b2c763fa3122bfbbcca14540e4f13eed3627b,
        0x54d65f19216c1b7ead3bf2369982b1f09932aadf93cb85a64c119c0775de83b9,
        0xe35b72aae410060433a88f55486572797a51cb8ac9e9dc0a3a094d1f3f20eff7,
        0x20a2d724cd883f7fff79283dba2ff5d568be20122ca8e7e122c74bdbf32976fa,
        0x1f537bca33ef5557eb70aeeb8d74b5bfe1d6bdae91c3d0002893be78a25662d7,
        0x843dd875d9a77577e985c9d40ee21292877161c55d98eb0cc30c50f6d9ae6a33,
        0x36ae5766215c84680cfbab2e661bc0be8c64184710047a749e5aa03607c4d804,
        0x5e48461a227a157cc76295563f9c9d7fb32365087c8703125444438e7fa9c0aa
    ];*/

    function setUp() public {
        //跳過開盲盲盒
        /*
         name： CarMan_Metaverse
         symbol: CMM
         _initBaseURI: ipfs.io/ipfs/QmYvJEw4LHBpaehH6mYZV9YXC372QSWL4BPFVJvUkKqRCg/
         _initNotRevealedUri: ipfs.io/ipfs/QmYvJEw4LHBpaehH6mYZV9YXC372QSWL4BPFVJvUkKqRCg/
        */
        vm.startPrank(0xb8A813833b6032b90a658231E1AA71Da1E7eA2ed);
        carManOpt = new CarManOpt(
            "Carman Metaverse",
            "CMM",
             "ipfs.io/ipfs/QmYvJEw4LHBpaehH6mYZV9YXC372QSWL4BPFVJvUkKqRCg/",
             "ipfs.io/ipfs/QmYvJEw4LHBpaehH6mYZV9YXC372QSWL4BPFVJvUkKqRCg/"
        );

        //新增controller
        carManOpt.addController(0xb8A813833b6032b90a658231E1AA71Da1E7eA2ed);
        carManOpt.addController(0xD6f8d12Af51f38E3df5E1d0A36bFC9C87c6eafD4);
        carManOpt.addController(0xf69d4A0397201670018E3c45Bf3143f6fF83E528);

        
        
        //設定各階段開賣時間
        carManOpt.setPublicSaleStart(1600000000);
        carManOpt.setPreSaleStart(1600000000);
        carManOpt.setVIPSaleStart(1600000000);

        //打開preSalePause
        carManOpt.setPreSalePause(false);

        //設定timestamp
        vm.warp(1600000001);
        
        //設定Merkle Tree Root
        carManOpt.setMerkleTreeRoot(0x57bdeb65ef1a00305a5c29269e561607a4a09a527db7c66c92b45f0006a1963d);

        vm.stopPrank();

        // init proof1
        proof1.push(0xe5ac2198cec9e672d35ba640253386ed61265e2546a13fdb5fba260f2759cf18);
        proof1.push(0x18a7d99cef2e21775b00bd58c9d69b26425c5b15cf58de93087526f82f510ed2);
        proof1.push(0x64de9e634a7a69fdb091b5ffa69c5f03238c2b88f61203841244f3c145c11b7a);
        proof1.push(0x9fd39917daa8729937d3c07ac89d8f9ddc876f3fd6bab7cbf7fbf906b0c341dc);
        proof1.push(0x2c2d3ba38d25732cc1249a561314f60070c06f5d59bd3bd34aef376f3bd6e892);
        proof1.push(0x75f6f80724678d0b10357f34809fa148b81ae9776b52ba771fcadac1d6d7af98);
        proof1.push(0x21ae192c0a02bc9ed8f74fb1c028e49cf0323f9fbdbefbb37422beb84d20682a);
        proof1.push(0x00ff2267102e38b70d0bf36d66a2cef6995988a5d68991c15b18208a7a398695);
        proof1.push(0x027bfbe8b2c130b9d55be52f86d4e940f4ac421b9b52f0fa9514e7c7972f87f2);
        proof1.push(0x5e48461a227a157cc76295563f9c9d7fb32365087c8703125444438e7fa9c0aa);

        //init proof2
        proof2.push(0xc84747cf5e222f288a79b555a8f9dafc516d29891c653fba46d3de8d1422f156);
        proof2.push(0x3f451c96289948d48e00922a59c17861b137dbf6a638cc210643eb46d80c44f9);
        proof2.push(0xc2d602830a0c398e71953719e20b2c763fa3122bfbbcca14540e4f13eed3627b);
        proof2.push(0x54d65f19216c1b7ead3bf2369982b1f09932aadf93cb85a64c119c0775de83b9);
        proof2.push(0xe35b72aae410060433a88f55486572797a51cb8ac9e9dc0a3a094d1f3f20eff7);
        proof2.push(0x20a2d724cd883f7fff79283dba2ff5d568be20122ca8e7e122c74bdbf32976fa);
        proof2.push(0x1f537bca33ef5557eb70aeeb8d74b5bfe1d6bdae91c3d0002893be78a25662d7);
        proof2.push(0x843dd875d9a77577e985c9d40ee21292877161c55d98eb0cc30c50f6d9ae6a33);
        proof2.push(0x36ae5766215c84680cfbab2e661bc0be8c64184710047a749e5aa03607c4d804);
        proof2.push(0x5e48461a227a157cc76295563f9c9d7fb32365087c8703125444438e7fa9c0aa);
    }

    //測試成功帳戶
    function testSuccessPreMint() public {
        // 第4個白名單：0xD6f8d12Af51f38E3df5E1d0A36bFC9C87c6eafD4 mint成功
        vm.startPrank(0xD6f8d12Af51f38E3df5E1d0A36bFC9C87c6eafD4);
        deal(address(0xD6f8d12Af51f38E3df5E1d0A36bFC9C87c6eafD4), 100 ether);
        carManOpt.preSaleMint{value: 1 ether}(proof1, 2);
        vm.stopPrank();

        assertEqUint(carManOpt.balanceOf(0xD6f8d12Af51f38E3df5E1d0A36bFC9C87c6eafD4), 2);

    }
     //測試失敗帳戶
    function testErrorPreMint() public {
        // 第434個白名單：0xf69d4A0397201670018E3c45Bf3143f6fF83E528 mint失敗，錯誤為：out of gas
        vm.startPrank(0xf69d4A0397201670018E3c45Bf3143f6fF83E528);
        deal(address(0xf69d4A0397201670018E3c45Bf3143f6fF83E528), 100 ether);
        carManOpt.preSaleMint{value: 1 ether}(proof2, 2);
        vm.stopPrank();

        //console.log(carman.balanceOf(0xf69d4A0397201670018E3c45Bf3143f6fF83E528));
        assertEqUint(carManOpt.balanceOf(0xf69d4A0397201670018E3c45Bf3143f6fF83E528), 2);

    }
    
}
