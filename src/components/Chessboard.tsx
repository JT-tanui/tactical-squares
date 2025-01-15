import { useState } from "react";
import { isValidMove, themes, type Theme, type Position } from "@/utils/chessUtils";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

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
  const [selectedSquare, setSelectedSquare] = useState<Position | null>(null);
  const [currentTheme, setCurrentTheme] = useState<Theme>(themes[0]);
  const [isWhiteTurn, setIsWhiteTurn] = useState(true);

  const handleSquareClick = (row: number, col: number) => {
    const clickedPosition: Position = [row, col];
    const piece = board[row][col];
    
    // If no square is selected, select this square if it has a piece of the current player's color
    if (!selectedSquare) {
      if (piece && (isWhiteTurn === (piece === piece.toUpperCase()))) {
        setSelectedSquare(clickedPosition);
      }
      return;
    }
    
    // If clicking the same square, deselect it
    if (selectedSquare[0] === row && selectedSquare[1] === col) {
      setSelectedSquare(null);
      return;
    }
    
    // Try to move the piece
    const [fromRow, fromCol] = selectedSquare;
    const movingPiece = board[fromRow][fromCol];
    
    if (isValidMove(movingPiece, selectedSquare, clickedPosition, board)) {
      const newBoard = board.map(row => [...row]);
      newBoard[row][col] = movingPiece;
      newBoard[fromRow][fromCol] = "";
      
      setBoard(newBoard);
      setSelectedSquare(null);
      setIsWhiteTurn(!isWhiteTurn);
    } else {
      // If the move is invalid and clicking another piece of the same color, select that piece instead
      if (piece && (isWhiteTurn === (piece === piece.toUpperCase()))) {
        setSelectedSquare(clickedPosition);
      } else {
        setSelectedSquare(null);
      }
    }
  };

  const handleThemeChange = (themeId: string) => {
    const newTheme = themes.find(t => t.id === themeId) || themes[0];
    setCurrentTheme(newTheme);
  };

  return (
    <div className="space-y-4">
      <div className="w-full max-w-xs mx-auto">
        <Select onValueChange={handleThemeChange} defaultValue={currentTheme.id}>
          <SelectTrigger className="w-full">
            <SelectValue placeholder="Select theme" />
          </SelectTrigger>
          <SelectContent>
            {themes.map((theme) => (
              <SelectItem key={theme.id} value={theme.id}>
                {theme.name}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>
      </div>
      
      <div className="w-full max-w-2xl mx-auto aspect-square">
        <div className="grid grid-cols-8 h-full">
          {board.map((row, rowIndex) =>
            row.map((piece, colIndex) => (
              <div
                key={`${rowIndex}-${colIndex}`}
                className={`
                  flex items-center justify-center text-3xl
                  ${(rowIndex + colIndex) % 2 === 0 
                    ? `bg-[${currentTheme.lightSquare}]` 
                    : `bg-[${currentTheme.darkSquare}]`}
                  ${selectedSquare && 
                    selectedSquare[0] === rowIndex && 
                    selectedSquare[1] === colIndex
                    ? `ring-2 ring-[${currentTheme.accent}]`
                    : ""}
                  cursor-pointer
                  hover:opacity-90
                  transition-opacity
                `}
                onClick={() => handleSquareClick(rowIndex, colIndex)}
              >
                {getPieceSymbol(piece, currentTheme.pieces)}
              </div>
            ))
          )}
        </div>
      </div>
      
      <div className="text-center text-chess-secondary">
        {isWhiteTurn ? "White's turn" : "Black's turn"}
      </div>
    </div>
  );
};

const getPieceSymbol = (piece: string, style: Theme['pieces'] = 'classic') => {
  const pieces: { [key: string]: { [key in Theme['pieces']]: string } } = {
    k: {
      classic: "♔", modern: "♔", minimalist: "K", abstract: "◆", neon: "K"
    },
    q: {
      classic: "♕", modern: "♕", minimalist: "Q", abstract: "◇", neon: "Q"
    },
    r: {
      classic: "♖", modern: "♖", minimalist: "R", abstract: "□", neon: "R"
    },
    b: {
      classic: "♗", modern: "♗", minimalist: "B", abstract: "△", neon: "B"
    },
    n: {
      classic: "♘", modern: "♘", minimalist: "N", abstract: "○", neon: "N"
    },
    p: {
      classic: "♙", modern: "♙", minimalist: "P", abstract: "•", neon: "P"
    },
    K: {
      classic: "♚", modern: "♚", minimalist: "k", abstract: "◆", neon: "k"
    },
    Q: {
      classic: "♛", modern: "♛", minimalist: "q", abstract: "◇", neon: "q"
    },
    R: {
      classic: "♜", modern: "♜", minimalist: "r", abstract: "□", neon: "r"
    },
    B: {
      classic: "♝", modern: "♝", minimalist: "b", abstract: "△", neon: "b"
    },
    N: {
      classic: "♞", modern: "♞", minimalist: "n", abstract: "○", neon: "n"
    },
    P: {
      classic: "♟", modern: "♟", minimalist: "p", abstract: "•", neon: "p"
    },
  };
  return pieces[piece]?.[style] || "";
};

export default Chessboard;