import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import Navigation from "@/components/Navigation";
import { Users, Trophy, Timer, Medal } from "lucide-react";
import Chessboard from "@/components/Chessboard";

const Play = () => {
  return (
    <div className="min-h-screen bg-chess-primary">
      <main className="container mx-auto px-4 py-8 pb-24">
        <header className="text-center mb-8">
          <h1 className="text-4xl font-bold text-chess-light mb-2">Play Online</h1>
          <p className="text-chess-secondary">Challenge players from around the world</p>
        </header>

        <div className="mb-8">
          <Chessboard />
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <Users className="h-5 w-5" />
                Quick Match
              </CardTitle>
              <CardDescription className="text-chess-secondary">Find opponents at your level</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-2 text-chess-secondary">
                <button className="w-full p-2 rounded bg-chess-primary hover:bg-chess-accent transition-colors">Casual Match</button>
                <button className="w-full p-2 rounded bg-chess-primary hover:bg-chess-accent transition-colors">Rated Match</button>
                <button className="w-full p-2 rounded bg-chess-primary hover:bg-chess-accent transition-colors">Tournament Play</button>
              </div>
            </CardContent>
          </Card>

          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <Timer className="h-5 w-5" />
                Time Controls
              </CardTitle>
              <CardDescription className="text-chess-secondary">Choose your game pace</CardDescription>
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
                <Trophy className="h-5 w-5" />
                Tournaments
              </CardTitle>
              <CardDescription className="text-chess-secondary">Compete in events</CardDescription>
            </CardHeader>
            <CardContent className="text-chess-secondary">
              <ul className="space-y-2">
                <li>• Daily tournaments</li>
                <li>• Weekly championships</li>
                <li>• Special events</li>
                <li>• Prize tournaments</li>
              </ul>
            </CardContent>
          </Card>

          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <Medal className="h-5 w-5" />
                Leaderboards
              </CardTitle>
              <CardDescription className="text-chess-secondary">Track your rankings</CardDescription>
            </CardHeader>
            <CardContent className="text-chess-secondary">
              <ul className="space-y-2">
                <li>• Global rankings</li>
                <li>• Regional rankings</li>
                <li>• Rating categories</li>
                <li>• Tournament standings</li>
              </ul>
            </CardContent>
          </Card>
        </div>
      </main>
      <Navigation />
    </div>
  );
};

export default Play;