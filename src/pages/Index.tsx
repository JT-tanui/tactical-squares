import Navigation from "@/components/Navigation";
import Chessboard from "@/components/Chessboard";

const Index = () => {
  return (
    <div className="min-h-screen bg-chess-primary">
      <main className="container mx-auto px-4 py-8">
        <header className="text-center mb-8">
          <h1 className="text-4xl font-bold text-chess-light mb-2">Chess AI Coach</h1>
          <p className="text-chess-secondary">Master the game with AI-powered guidance</p>
        </header>
        
        <div className="mb-8">
          <Chessboard />
        </div>
        
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8">
          <div className="bg-chess-dark p-6 rounded-lg">
            <h2 className="text-xl font-bold text-chess-light mb-4">Quick Start</h2>
            <ul className="space-y-2 text-chess-secondary">
              <li>• Learn chess fundamentals</li>
              <li>• Practice with AI opponent</li>
              <li>• Analyze your games</li>
              <li>• Track your progress</li>
            </ul>
          </div>
          
          <div className="bg-chess-dark p-6 rounded-lg">
            <h2 className="text-xl font-bold text-chess-light mb-4">Daily Challenge</h2>
            <p className="text-chess-secondary">
              Complete today's puzzle to improve your tactical skills
            </p>
            <button className="mt-4 bg-chess-accent text-chess-primary px-4 py-2 rounded hover:opacity-90 transition-opacity">
              Start Challenge
            </button>
          </div>
        </div>
      </main>
      <Navigation />
    </div>
  );
};

export default Index;