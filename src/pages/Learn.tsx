import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import Navigation from "@/components/Navigation";
import { BookOpen, Video, Target, Trophy } from "lucide-react";

const Learn = () => {
  return (
    <div className="min-h-screen bg-chess-primary">
      <main className="container mx-auto px-4 py-8 pb-24">
        <header className="text-center mb-8">
          <h1 className="text-4xl font-bold text-chess-light mb-2">Learn Chess</h1>
          <p className="text-chess-secondary">Master the fundamentals and advanced concepts</p>
        </header>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <BookOpen className="h-5 w-5" />
                Fundamentals
              </CardTitle>
              <CardDescription className="text-chess-secondary">Learn the basic rules and piece movements</CardDescription>
            </CardHeader>
            <CardContent className="text-chess-secondary">
              <ul className="space-y-2">
                <li>• Piece movements and special rules</li>
                <li>• Basic checkmate patterns</li>
                <li>• Pawn structure fundamentals</li>
                <li>• Opening principles</li>
              </ul>
            </CardContent>
          </Card>

          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <Video className="h-5 w-5" />
                Video Lessons
              </CardTitle>
              <CardDescription className="text-chess-secondary">Watch and learn from expert players</CardDescription>
            </CardHeader>
            <CardContent className="text-chess-secondary">
              <ul className="space-y-2">
                <li>• Strategic concepts</li>
                <li>• Tactical patterns</li>
                <li>• Famous games analysis</li>
                <li>• Expert commentary</li>
              </ul>
            </CardContent>
          </Card>

          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <Target className="h-5 w-5" />
                Puzzles
              </CardTitle>
              <CardDescription className="text-chess-secondary">Improve your tactical vision</CardDescription>
            </CardHeader>
            <CardContent className="text-chess-secondary">
              <ul className="space-y-2">
                <li>• Daily puzzles</li>
                <li>• Themed challenges</li>
                <li>• Rating-based selection</li>
                <li>• Solution explanations</li>
              </ul>
            </CardContent>
          </Card>

          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <Trophy className="h-5 w-5" />
                Progress Tracking
              </CardTitle>
              <CardDescription className="text-chess-secondary">Track your learning journey</CardDescription>
            </CardHeader>
            <CardContent className="text-chess-secondary">
              <ul className="space-y-2">
                <li>• Skill assessment</li>
                <li>• Progress metrics</li>
                <li>• Achievement system</li>
                <li>• Learning recommendations</li>
              </ul>
            </CardContent>
          </Card>
        </div>
      </main>
      <Navigation />
    </div>
  );
};

export default Learn;