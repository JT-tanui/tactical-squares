import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import Navigation from "@/components/Navigation";
import { User, Trophy, Activity, History, Brain, Target } from "lucide-react";

const Profile = () => {
  return (
    <div className="min-h-screen bg-chess-primary">
      <main className="container mx-auto px-4 py-8 pb-24">
        <header className="text-center mb-8">
          <div className="w-24 h-24 mx-auto mb-4 rounded-full bg-chess-dark border-4 border-chess-accent flex items-center justify-center">
            <User className="w-12 h-12 text-chess-light" />
          </div>
          <h1 className="text-4xl font-bold text-chess-light mb-2">Player Profile</h1>
          <p className="text-chess-secondary">Member since 2024</p>
        </header>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <Trophy className="h-5 w-5" />
                Rankings
              </CardTitle>
              <CardDescription className="text-chess-secondary">Your current ratings</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-2 text-chess-secondary">
                <div className="flex justify-between items-center">
                  <span>Bullet Rating:</span>
                  <span className="font-bold">1200</span>
                </div>
                <div className="flex justify-between items-center">
                  <span>Blitz Rating:</span>
                  <span className="font-bold">1350</span>
                </div>
                <div className="flex justify-between items-center">
                  <span>Rapid Rating:</span>
                  <span className="font-bold">1450</span>
                </div>
                <div className="flex justify-between items-center">
                  <span>Classical Rating:</span>
                  <span className="font-bold">1500</span>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <Activity className="h-5 w-5" />
                Statistics
              </CardTitle>
              <CardDescription className="text-chess-secondary">Your performance metrics</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-2 text-chess-secondary">
                <div className="flex justify-between items-center">
                  <span>Games Played:</span>
                  <span className="font-bold">250</span>
                </div>
                <div className="flex justify-between items-center">
                  <span>Win Rate:</span>
                  <span className="font-bold">52%</span>
                </div>
                <div className="flex justify-between items-center">
                  <span>Draw Rate:</span>
                  <span className="font-bold">28%</span>
                </div>
                <div className="flex justify-between items-center">
                  <span>Average Game Length:</span>
                  <span className="font-bold">35 moves</span>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <Brain className="h-5 w-5" />
                Learning Progress
              </CardTitle>
              <CardDescription className="text-chess-secondary">Your improvement journey</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-2 text-chess-secondary">
                <div className="flex justify-between items-center">
                  <span>Puzzles Solved:</span>
                  <span className="font-bold">500</span>
                </div>
                <div className="flex justify-between items-center">
                  <span>Puzzle Rating:</span>
                  <span className="font-bold">1600</span>
                </div>
                <div className="flex justify-between items-center">
                  <span>Lessons Completed:</span>
                  <span className="font-bold">25</span>
                </div>
                <div className="flex justify-between items-center">
                  <span>Study Time:</span>
                  <span className="font-bold">50 hours</span>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <History className="h-5 w-5" />
                Recent Games
              </CardTitle>
              <CardDescription className="text-chess-secondary">Your latest matches</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-2 text-chess-secondary">
                <div className="flex justify-between items-center">
                  <span>vs. Player1</span>
                  <span className="font-bold text-green-400">Won</span>
                </div>
                <div className="flex justify-between items-center">
                  <span>vs. Player2</span>
                  <span className="font-bold text-yellow-400">Draw</span>
                </div>
                <div className="flex justify-between items-center">
                  <span>vs. Player3</span>
                  <span className="font-bold text-red-400">Lost</span>
                </div>
                <div className="flex justify-between items-center">
                  <span>vs. Player4</span>
                  <span className="font-bold text-green-400">Won</span>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </main>
      <Navigation />
    </div>
  );
};

export default Profile;