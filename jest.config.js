// jest.config.js
module.exports = {
  transform: {
    "^.+\\.(jsx?)$": "babel-jest",
  },
  testEnvironment: "jest-environment-jsdom",
  moduleFileExtensions: ["js", "jsx"],
  setupFilesAfterEnv: ["<rootDir>/setupTests.js"],
};
