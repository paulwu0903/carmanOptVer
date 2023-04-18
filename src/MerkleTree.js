const { MerkleTree } = require("merkletreejs");
const keccak256 = require("keccak256");
const whitelistJSON = require("./whitelist1");

// 透過 merkletreejs 套件產生 merkle tree
function getMerkle(whiteList) {
  const leafs = whiteList.map((addr) => keccak256(addr));
  return new MerkleTree(leafs, keccak256, { sortPairs: true });
}
const whitelistMerkleTree = getMerkle(whitelistJSON);
// console.log("merkle", whitelistMerkleTree);

// 取得 merkle tree 的 root
const root = whitelistMerkleTree.getRoot();
console.log("address: ", "0xf69d4A0397201670018E3c45Bf3143f6fF83E528");
console.log("root", bufferToBytes32(root));

// 取得 proof
function getProof(address) {
  const leaf = keccak256(address);
  return whitelistMerkleTree.getProof(leaf).map((p) => bufferToBytes32(p.data));
}
console.log("proof", getProof("0xD6f8d12Af51f38E3df5E1d0A36bFC9C87c6eafD4"));

// 驗證 proof
function verify(address) {
  const leaf = keccak256(address);
  const proof = getProof(address);
  return whitelistMerkleTree.verify(proof, leaf, root);
}
//console.log("verify", verify("0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"));

// 將 buffer 轉成 bytes32
function bufferToBytes32(buffer) {
  return "0x" + buffer.toString("hex").padStart(64, "0");
}

