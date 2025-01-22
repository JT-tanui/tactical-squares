export type Theme = {
  id: string;
  name: string;
  pieces: "classic" | "modern" | "minimalist" | "abstract" | "neon";
};

export const themes: Theme[] = [
  { id: "classic", name: "Classic Wood", pieces: "classic" },
  { id: "modern", name: "Modern Blue", pieces: "modern" },
  { id: "darkula", name: "Darkula", pieces: "classic" },
  { id: "forest", name: "Forest Green", pieces: "modern" },
  { id: "midnight", name: "Midnight", pieces: "classic" },
];

export type Position = [number, number];

export const isValidMove = (piece: string, from: Position, to: Position, board: string[][]): boolean => {
  const [fromRow, fromCol] = from;
  const [toRow, toCol] = to;

  // Basic movement rules for each piece
  switch (piece.toLowerCase()) {
    case 'p': // Pawn
      return (fromCol === toCol && toRow === fromRow + 1 && !board[toRow][toCol]) || // Move forward
             (fromCol === toCol && toRow === fromRow + 2 && fromRow === 1 && !board[toRow][toCol] && !board[fromRow + 1][toCol]); // Double move
    case 'r': // Rook
      return (fromRow === toRow || fromCol === toCol) && !isPathBlocked(from, to, board);
    case 'n': // Knight
      return (Math.abs(fromRow - toRow) === 2 && Math.abs(fromCol - toCol) === 1) ||
             (Math.abs(fromRow - toRow) === 1 && Math.abs(fromCol - toCol) === 2);
    case 'b': // Bishop
      return Math.abs(fromRow - toRow) === Math.abs(fromCol - toCol) && !isPathBlocked(from, to, board);
    case 'q': // Queen
      return (fromRow === toRow || fromCol === toCol || Math.abs(fromRow - toRow) === Math.abs(fromCol - toCol)) && !isPathBlocked(from, to, board);
    case 'k': // King
      return Math.abs(fromRow - toRow) <= 1 && Math.abs(fromCol - toCol) <= 1;
    default:
      return false;
  }
};

const isPathBlocked = (from: Position, to: Position, board: string[][]): boolean => {
  const [fromRow, fromCol] = from;
  const [toRow, toCol] = to;

  const rowStep = toRow > fromRow ? 1 : toRow < fromRow ? -1 : 0;
  const colStep = toCol > fromCol ? 1 : toCol < fromCol ? -1 : 0;

  let currentRow = fromRow + rowStep;
  let currentCol = fromCol + colStep;

  while (currentRow !== toRow || currentCol !== toCol) {
    if (board[currentRow][currentCol]) {
      return true; // Path is blocked
    }
    currentRow += rowStep;
    currentCol += colStep;
  }
  return false; // Path is clear
};
