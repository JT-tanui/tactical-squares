import { useState } from "react";

const initialBoard = [
  ["r", "n", "b", "q", "k", "b", "n", "r"],
  ["p", "p", "p", "p", "p", "p", "p", "p"],
  Array(8).fill(""),
  Array(8).fill(""),
  Array(8).fill(""),
  Array(8).fill(""),
  ["P", "P", "P", "P", "P", "P", "P", "P"],
  ["R", "N", "B", "Q", "K", "B", "N", "R"],
];

const Chessboard = () => {
  const [board, setBoard] = useState(initialBoard);
  const [selectedSquare, setSelectedSquare] = useState<number[]>([]);

  const handleSquareClick = (row: number, col: number) => {
    console.log(`Clicked square at row ${row}, col ${col}`);
    setSelectedSquare([row, col]);
  };

  return (
    <div className="w-full max-w-2xl mx-auto aspect-square">
      <div className="grid grid-cols-8 h-full">
        {board.map((row, rowIndex) =>
          row.map((piece, colIndex) => (
            <div
              key={`${rowIndex}-${colIndex}`}
              className={`
                flex items-center justify-center text-3xl
                ${(rowIndex + colIndex) % 2 === 0 ? "bg-chess-light" : "bg-chess-secondary"}
                ${
                  selectedSquare[0] === rowIndex && selectedSquare[1] === colIndex
                    ? "ring-2 ring-chess-accent"
                    : ""
                }
                cursor-pointer
                hover:opacity-90
                transition-opacity
              `}
              onClick={() => handleSquareClick(rowIndex, colIndex)}
            >
              {getPieceSymbol(piece)}
            </div>
          ))
        )}
      </div>
    </div>
  );
};

const getPieceSymbol = (piece: string) => {
  const pieces: { [key: string]: string } = {
    k: "♔", q: "♕", r: "♖", b: "♗", n: "♘", p: "♙",
    K: "♚", Q: "♛", R: "♜", B: "♝", N: "♞", P: "♟",
  };
  return pieces[piece] || "";
};

export default Chessboard;