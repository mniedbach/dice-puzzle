//
//  DiceBoardTests.swift
//  DicePuzzleTests
//
//  Created by Marek Niedbach on 02/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import XCTest
import DicePuzzle

class DiceBoardTests: XCTestCase {
    func testNewBoardContainsOnes() {
        let sut = DiceBoard(size: 2)

        XCTAssertEqual(dices(in: sut), [[.one, .one],
                                        [.one, .one]])
    }

    func testInitializedBoardDontContainsDicesOutsideBoard() {
        let sut = DiceBoard(size: 1)

        XCTAssertNil(sut.dice(atRow: 0, col: 1))
        XCTAssertNil(sut.dice(atRow: 1, col: 0))
    }

    func testBoardSize() {
        XCTAssertEqual(DiceBoard(size: 1).size, 1)
        XCTAssertEqual(DiceBoard(size: 5).size, 5)
    }

    func testSwapRow() {
        let sut = DiceBoard(size: 2)

        sut.swap(rowAt: 1, direction: .forward)
        sut.swap(rowAt: 1, direction: .forward)
        sut.swap(rowAt: 1, direction: .forward)

        XCTAssertEqual(dices(in: sut), [[.one, .one],
                                        [.four, .four]])
    }

    func testSwapColumn() {
        let sut = DiceBoard(size: 2)

        sut.swap(colAt: 0, direction: .forward)
        sut.swap(colAt: 0, direction: .forward)

        XCTAssertEqual(dices(in: sut), [[.three, .one],
                                        [.three, .one]])
    }

    func testSwapDiagonalDexter() {
        let sut = DiceBoard(size: 2)

        sut.swap(diagonal: .dexter, direction: .forward)

        XCTAssertEqual(dices(in: sut), [[.two, .one],
                                        [.one, .two]])
    }

    func testSwapDiagonalSinister() {
        let sut = DiceBoard(size: 2)

        sut.swap(diagonal: .sinister, direction: .forward)

        XCTAssertEqual(dices(in: sut), [[.one, .two],
                                        [.two, .one]])
    }

    func testBoardIsResolvedIfUnchanged() {
        XCTAssertTrue(DiceBoard(size: 2).isResolved)
    }

    func testBoardIsNotResolvedIfChanged() {
        let sut = DiceBoard(size: 2)
        sut.swap(rowAt: 0, direction: .forward)

        XCTAssertFalse(sut.isResolved)
    }

    func testBoardIsResolvedWhenFilledWithAnyOtherDice() {
        let sut = DiceBoard(size: 2)
        sut.swap(rowAt: 0, direction: .forward)
        sut.swap(rowAt: 0, direction: .forward)
        sut.swap(rowAt: 1, direction: .forward)
        sut.swap(rowAt: 1, direction: .forward)

        XCTAssertTrue(sut.isResolved)
    }

    private func dices(in board: DiceBoard) -> [[Dice]] {
        var dices = [[Dice]]()
        for row in 0... {
            guard board.dice(atRow: row, col: 0) != nil else { break }

            var dicesRow = [Dice]()
            for col in 0... {
                guard let dice = board.dice(atRow: row, col: col) else { break }

                dicesRow.append(dice)
            }
            dices.append(dicesRow)
        }
        return dices
    }
}