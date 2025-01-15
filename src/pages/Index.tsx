import { useState } from "react";
import Navigation from "@/components/Navigation";
import Chessboard from "@/components/Chessboard";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { ChevronLeft, ChevronRight, BookOpen, Target, Swords, Trophy } from "lucide-react";
import { cn } from "@/lib/utils";

const Index = () => {
  const [currentSlide, setCurrentSlide] = useState(0);

  const carouselItems = [
    {
      title: "Daily Puzzle",
      description: "Test your tactical skills with today's challenge",
      icon: <Target className="w-6 h-6" />,
      action: "Solve Now",
    },
    {
      title: "Learn Openings",
      description: "Master the art of chess openings",
      icon: <BookOpen className="w-6 h-6" />,
      action: "Start Learning",
    },
    {
      title: "Play vs AI",
      description: "Challenge our adaptive AI opponent",
      icon: <Swords className="w-6 h-6" />,
      action: "Play Now",
    },
  ];

  const nextSlide = () => {
    setCurrentSlide((prev) => (prev + 1) % carouselItems.length);
  };

  const prevSlide = () => {
    setCurrentSlide((prev) => (prev - 1 + carouselItems.length) % carouselItems.length);
  };

  return (
    <div className="min-h-screen bg-chess-primary">
      <main className="container mx-auto px-4 py-8 space-y-8">
        <header className="text-center mb-8 animate-fade-in">
          <h1 className="text-4xl font-bold text-chess-light mb-2 font-serif">Chess AI Coach</h1>
          <p className="text-chess-secondary font-sans">Master the game with AI-powered guidance</p>
        </header>

        {/* Carousel Section */}
        <div className="relative max-w-4xl mx-auto mb-12">
          <div className="overflow-hidden rounded-lg bg-chess-dark p-6">
            <div className="flex items-center justify-between">
              <button
                onClick={prevSlide}
                className="p-2 rounded-full bg-chess-primary/20 hover:bg-chess-primary/40 text-chess-light transition-colors"
              >
                <ChevronLeft className="w-6 h-6" />
              </button>
              
              <div className="flex-1 px-8">
                <div className="text-center">
                  <div className="flex justify-center mb-4 text-chess-accent">
                    {carouselItems[currentSlide].icon}
                  </div>
                  <h3 className="text-2xl font-bold text-chess-light mb-2">
                    {carouselItems[currentSlide].title}
                  </h3>
                  <p className="text-chess-secondary mb-4">
                    {carouselItems[currentSlide].description}
                  </p>
                  <Button variant="outline" className="bg-chess-accent text-chess-primary hover:bg-chess-accent/90">
                    {carouselItems[currentSlide].action}
                  </Button>
                </div>
              </div>

              <button
                onClick={nextSlide}
                className="p-2 rounded-full bg-chess-primary/20 hover:bg-chess-primary/40 text-chess-light transition-colors"
              >
                <ChevronRight className="w-6 h-6" />
              </button>
            </div>
          </div>
          
          <div className="flex justify-center mt-4 gap-2">
            {carouselItems.map((_, index) => (
              <button
                key={index}
                className={cn(
                  "w-2 h-2 rounded-full transition-colors",
                  currentSlide === index ? "bg-chess-accent" : "bg-chess-secondary/30"
                )}
                onClick={() => setCurrentSlide(index)}
              />
            ))}
          </div>
        </div>

        {/* Chessboard Section */}
        <div className="mb-12">
          <Chessboard />
        </div>

        {/* Features Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <Trophy className="h-5 w-5" />
                Quick Start Guide
              </CardTitle>
            </CardHeader>
            <CardContent>
              <ul className="space-y-2 text-chess-secondary">
                <li className="flex items-center gap-2">
                  <div className="w-1.5 h-1.5 rounded-full bg-chess-accent" />
                  Learn chess fundamentals
                </li>
                <li className="flex items-center gap-2">
                  <div className="w-1.5 h-1.5 rounded-full bg-chess-accent" />
                  Practice with AI opponent
                </li>
                <li className="flex items-center gap-2">
                  <div className="w-1.5 h-1.5 rounded-full bg-chess-accent" />
                  Analyze your games
                </li>
                <li className="flex items-center gap-2">
                  <div className="w-1.5 h-1.5 rounded-full bg-chess-accent" />
                  Track your progress
                </li>
              </ul>
            </CardContent>
          </Card>

          <Card className="bg-chess-dark border-chess-accent">
            <CardHeader>
              <CardTitle className="text-chess-light flex items-center gap-2">
                <Target className="h-5 w-5" />
                Daily Challenge
              </CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-chess-secondary mb-4">
                Complete today's puzzle to improve your tactical skills
              </p>
              <Button className="w-full bg-chess-accent text-chess-primary hover:bg-chess-accent/90">
                Start Challenge
              </Button>
            </CardContent>
          </Card>
        </div>
      </main>
      <Navigation />
    </div>
  );
};

export default Index;