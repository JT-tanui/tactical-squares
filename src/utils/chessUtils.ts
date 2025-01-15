export type PieceType = 'p' | 'r' | 'n' | 'b' | 'q' | 'k' | 'P' | 'R' | 'N' | 'B' | 'Q' | 'K' | '';
export type Position = [number, number];

export interface Theme {
  id: string;
  name: string;
  lightSquare: string;
  darkSquare: string;
  accent: string;
  pieces: 'classic' | 'modern' | 'minimalist' | 'abstract' | 'neon';
}

export const themes: Theme[] = [
  {
    id: 'classic',
    name: 'Classic Wood',
    lightSquare: '#F0D9B5',
    darkSquare: '#B58863',
    accent: '#E4A853',
    pieces: 'classic'
  },
  {
    id: 'modern',
    name: 'Modern Blue',
    lightSquare: '#EBF0F5',
    darkSquare: '#4B7399',
    accent: '#5BA7D7',
    pieces: 'modern'
  },
  {
    id: 'forest',
    name: 'Forest Green',
    lightSquare: '#FFFFDD',
    darkSquare: '#86A666',
    accent: '#C4D89F',
    pieces: 'classic'
  },
  {
    id: 'midnight',
    name: 'Midnight',
    lightSquare: '#E8EDF9',
    darkSquare: '#4A4A4A',
    accent: '#7FA1E8',
    pieces: 'modern'
  },
  {
    id: 'coral',
    name: 'Coral Reef',
    lightSquare: '#FFF0E6',
    darkSquare: '#FB8F67',
    accent: '#FFB4A2',
    pieces: 'minimalist'
  },
  {
    id: 'neon',
    name: 'Neon Nights',
    lightSquare: '#2C2C2C',
    darkSquare: '#1A1A1A',
    accent: '#00FF9F',
    pieces: 'neon'
  }
];

const isValidPosition = (pos: Position): boolean => {
  const [row, col] = pos;
  return row >= 0 && row < 8 && col >= 0 && col < 8;
};

const isPieceWhite = (piece: string): boolean => {
  return piece === piece.toUpperCase();
};

// Helper function to check if path is clear for piece movement
const isPathClear = (from: Position, to: Position, board: string[][]): boolean => {
  const [fromRow, fromCol] = from;
  const [toRow, toCol] = to;
  
  const rowStep = toRow > fromRow ? 1 : toRow < fromRow ? -1 : 0;
  const colStep = toCol > fromCol ? 1 : toCol < fromCol ? -1 : 0;
  
  let currentRow = fromRow + rowStep;
  let currentCol = fromCol + colStep;
  
  while (currentRow !== toRow || currentCol !== toCol) {
    if (board[currentRow][currentCol] !== "") {
      return false;
    }
    currentRow += rowStep;
    currentCol += colStep;
  }
  
  return true;
};

export const isValidMove = (
  piece: string,
  from: Position,
  to: Position,
  board: string[][]
): boolean => {
  if (!isValidPosition(from) || !isValidPosition(to)) return false;
  
  const [fromRow, fromCol] = from;
  const [toRow, toCol] = to;
  const pieceType = piece.toLowerCase();
  const isWhite = isPieceWhite(piece);
  const targetPiece = board[toRow][toCol];
  
  // Can't capture own pieces
  if (targetPiece && isPieceWhite(targetPiece) === isWhite) {
    console.log('Cannot capture own piece');
    return false;
  }
  
  // Movement rules for each piece
  switch (pieceType) {
    case 'p': { // Pawn
      const direction = isWhite ? -1 : 1;
      const startRow = isWhite ? 6 : 1;
      
      // Basic one square move
      if (fromCol === toCol && toRow === fromRow + direction && !targetPiece) {
        return true;
      }
      
      // Initial two square move
      if (fromCol === toCol && fromRow === startRow && 
          toRow === fromRow + 2 * direction && 
          !board[fromRow + direction][fromCol] && 
          !targetPiece) {
        return true;
      }
      
      // Capture diagonally
      if (Math.abs(toCol - fromCol) === 1 && 
          toRow === fromRow + direction && 
          targetPiece) {
        return true;
      }
      
      return false;
    }
    
    case 'r': // Rook
      if (fromRow === toRow || fromCol === toCol) {
        return isPathClear(from, to, board);
      }
      return false;
      
    case 'n': // Knight
      return (Math.abs(fromRow - toRow) === 2 && Math.abs(fromCol - toCol) === 1) ||
             (Math.abs(fromRow - toRow) === 1 && Math.abs(fromCol - toCol) === 2);
      
    case 'b': // Bishop
      if (Math.abs(fromRow - toRow) === Math.abs(fromCol - toCol)) {
        return isPathClear(from, to, board);
      }
      return false;
      
    case 'q': // Queen
      if (fromRow === toRow || fromCol === toCol || 
          Math.abs(fromRow - toRow) === Math.abs(fromCol - toCol)) {
        return isPathClear(from, to, board);
      }
      return false;
      
    case 'k': // King
      return Math.abs(fromRow - toRow) <= 1 && Math.abs(fromCol - toCol) <= 1;
      
    default:
      return false;
  }
};