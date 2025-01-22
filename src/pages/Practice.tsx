import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import Navigation from "@/components/Navigation";
import { Bot, Swords, Brain, Timer } from "lucide-react";
import Chessboard from "@/components/Chessboard";

const Practice = () => {
  return (
    <div className="min-h-screen bg-chess-primary">
      <main className="container mx-auto px-4 py-8 pb-24">
        <header className="text-center mb-8">
          <h1 className="text-4xl font-bold text-chess-light mb-2">Practice Mode</h1>
          <p className="text-chess-secondary">Improve your game against AI opponents</p>
        </header>

        <div className="mb-8">
          <Chessboard />
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <Bot className="h-5 w-5" />
                AI Difficulty
              </CardTitle>
              <CardDescription className="text-chess-secondary">Choose your opponent's strength</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-2 text-chess-secondary">
                <button className="w-full p-2 rounded bg-chess-primary hover:bg-chess-accent transition-colors">Beginner (ELO 800)</button>
                <button className="w-full p-2 rounded bg-chess-primary hover:bg-chess-accent transition-colors">Intermediate (ELO 1200)</button>
                <button className="w-full p-2 rounded bg-chess-primary hover:bg-chess-accent transition-colors">Advanced (ELO 1600)</button>
                <button className="w-full p-2 rounded bg-chess-primary hover:bg-chess-accent transition-colors">Expert (ELO 2000+)</button>
              </div>
            </CardContent>
          </Card>

          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <Brain className="h-5 w-5" />
                Training Focus
              </CardTitle>
              <CardDescription className="text-chess-secondary">Specialized practice modes</CardDescription>
            </CardHeader>
            <CardContent className="text-chess-secondary">
              <ul className="space-y-2">
                <li>• Opening preparation</li>
                <li>• Endgame practice</li>
                <li>• Tactical training</li>
                <li>• Position analysis</li>
              </ul>
            </CardContent>
          </Card>

          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <Timer className="h-5 w-5" />
                Time Controls
              </CardTitle>
              <CardDescription className="text-chess-secondary">Practice with different time settings</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-2 text-chess-secondary">
                <button className="w-full p-2 rounded bg-chess-primary hover:bg-chess-accent transition-colors">Bullet (1 min)</button>
                <button className="w-full p-2 rounded bg-chess-primary hover:bg-chess-accent transition-colors">Blitz (5 min)</button>
                <button className="w-full p-2 rounded bg-chess-primary hover:bg-chess-accent transition-colors">Rapid (10 min)</button>
                <button className="w-full p-2 rounded bg-chess-primary hover:bg-chess-accent transition-colors">Classical (30 min)</button>
              </div>
            </CardContent>
          </Card>

          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <Swords className="h-5 w-5" />
                Game Analysis
              </CardTitle>
              <CardDescription className="text-chess-secondary">Review and improve</CardDescription>
            </CardHeader>
            <CardContent className="text-chess-secondary">
              <ul className="space-y-2">
                <li>• Move analysis</li>
                <li>• Mistake detection</li>
                <li>• Improvement suggestions</li>
                <li>• Save games for review</li>
              </ul>
            </CardContent>
          </Card>
        </div>
      </main>
      <Navigation />
    </div>
  );
};

export default Practice;