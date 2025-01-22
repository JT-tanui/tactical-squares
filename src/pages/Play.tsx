import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Slider } from "@/components/ui/slider";
import Navigation from "@/components/Navigation";
import { Users, Trophy, Timer, Medal, Brain, MessageCircle } from "lucide-react";
import Chessboard from "@/components/Chessboard";
import { useState } from "react";

const Play = () => {
  const [aiDifficulty, setAiDifficulty] = useState(1500);
  const [timeControl, setTimeControl] = useState("rapid");
  const [showCoaching, setShowCoaching] = useState(true);

  return (
    <div className="min-h-screen bg-chess-primary">
      <Navigation />
      <main className="md:ml-64 container mx-auto px-4 py-8 pb-24">
        <header className="text-center mb-8">
          <h1 className="text-4xl font-bold text-chess-light mb-2">Play Chess</h1>
          <p className="text-chess-secondary">Challenge the AI or play with friends</p>
        </header>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Main game area */}
          <div className="lg:col-span-2 space-y-6">
            <Card className="bg-chess-dark border-chess-accent">
              <CardHeader>
                <CardTitle className="text-chess-light flex items-center gap-2">
                  <Brain className="h-5 w-5" />
                  Game Settings
                </CardTitle>
                <CardDescription className="text-chess-secondary">Customize your game experience</CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <div>
                  <label className="text-chess-light block mb-2">AI Difficulty: {aiDifficulty} ELO</label>
                  <Slider
                    value={[aiDifficulty]}
                    onValueChange={(value) => setAiDifficulty(value[0])}
                    max={2500}
                    min={800}
                    step={100}
                    className="w-full"
                  />
                </div>
                <div className="grid grid-cols-3 gap-2">
                  {["bullet", "blitz", "rapid", "classical"].map((control) => (
                    <button
                      key={control}
                      onClick={() => setTimeControl(control)}
                      className={`p-2 rounded capitalize ${
                        timeControl === control
                          ? "bg-chess-accent text-chess-dark"
                          : "bg-chess-primary text-chess-light hover:bg-chess-accent/80"
                      }`}
                    >
                      {control}
                    </button>
                  ))}
                </div>
              </CardContent>
            </Card>

            <div className="w-full aspect-square max-w-3xl mx-auto">
              <Chessboard />
            </div>
          </div>

          {/* Sidebar */}
          <div className="space-y-6">
            <Card className="bg-chess-dark border-chess-accent">
              <CardHeader>
                <CardTitle className="text-chess-light flex items-center gap-2">
                  <MessageCircle className="h-5 w-5" />
                  AI Coach
                </CardTitle>
                <CardDescription className="text-chess-secondary">Real-time analysis and suggestions</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4 text-chess-secondary">
                  <div className="p-3 bg-chess-primary rounded">
                    <p className="font-semibold mb-1">Current Position:</p>
                    <p>Equal position with slight advantage for white</p>
                  </div>
                  <div className="p-3 bg-chess-primary rounded">
                    <p className="font-semibold mb-1">Suggested Move:</p>
                    <p>Consider e4 to control the center</p>
                  </div>
                  <div className="p-3 bg-chess-primary rounded">
                    <p className="font-semibold mb-1">Key Threats:</p>
                    <p>Watch out for the exposed king side</p>
                  </div>
                </div>
              </CardContent>
            </Card>

            <Card className="bg-chess-dark border-chess-accent">
              <CardHeader>
                <CardTitle className="text-chess-light flex items-center gap-2">
                  <Trophy className="h-5 w-5" />
                  Game Stats
                </CardTitle>
                <CardDescription className="text-chess-secondary">Current game information</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-2 text-chess-secondary">
                  <div className="flex justify-between">
                    <span>Move Count:</span>
                    <span>15</span>
                  </div>
                  <div className="flex justify-between">
                    <span>Time Remaining:</span>
                    <span>5:30</span>
                  </div>
                  <div className="flex justify-between">
                    <span>Position Score:</span>
                    <span>+0.5</span>
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </main>
    </div>
  );
};

export default Play;
